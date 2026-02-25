
from tkinter import *
from tkinter import messagebox, ttk
from PIL import Image, ImageTk
import mysql.connector


def conectare_baza_date():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="firma_transport_marfa"
    )


def seteaza_fundal(fereastra, cale_imagine):
    try:
        img = Image.open(cale_imagine)
        img = img.resize((1000, 600))
        bg_img = ImageTk.PhotoImage(img)
        eticheta = Label(fereastra, image=bg_img)
        eticheta.place(x=0, y=0, relwidth=1, relheight=1)
        fereastra.fundal = bg_img
    except Exception as e:
        print(f"Eroare la încărcarea fundalului: {e}")


def login():
    utilizator = camp_utilizator.get()
    parola = camp_parola.get()
    if utilizator == "admin" and parola == "Unire":
        messagebox.showinfo("Login", "Autentificare reușită!")
        fereastra_login.destroy()
        deschide_dashboard()
    else:
        messagebox.showerror("Eroare", "Username sau parolă incorecte.")


def deschide_dashboard():
    dash = Tk()
    dash.title("Dashboard")
    dash.geometry("1000x600")
    seteaza_fundal(dash, "background.jpg")


    Button(dash, text="Gestionare Camioane", font=("Arial", 12), command=lambda: fereastra_tabel("Masini", "background.jpg")).pack(pady=10)
    Button(dash, text="Gestionare Șoferi", font=("Arial", 12), command=lambda: fereastra_tabel("Soferi", "background.jpg")).pack(pady=10)
    Button(dash, text="Gestionare Transporturi", font=("Arial", 12), command=lambda: fereastra_tabel("Transporturi", "background.jpg")).pack(pady=10)
    Button(dash, text="Gestionare Revizii", font=("Arial", 12), command=lambda: fereastra_tabel("Revizii", "background.jpg")).pack(pady=10)
    Button(dash, text="Gestionare Alocări", font=("Arial", 12), command=lambda: fereastra_tabel("AlocariTransport", "background.jpg")).pack(pady=10)
    Button(dash, text="Interogări SQL", font=("Arial", 12), command=fereastra_interogari).pack(pady=10)


def fereastra_tabel(tabel, img):
    win = Toplevel()
    win.title(f"Gestionare {tabel}")
    win.geometry("1000x600")
    seteaza_fundal(win, img)
    conexiune = conectare_baza_date()
    cursor = conexiune.cursor()
    cursor.execute(f"DESCRIBE {tabel}")
    coloane = [col[0] for col in cursor.fetchall()]

    trv = ttk.Treeview(win, columns=coloane, show="headings")
    for col in coloane:
        trv.heading(col, text=col)
        trv.column(col, width=120)
    trv.place(x=20, y=50, width=960, height=200)

    def reincarca():
        for row in trv.get_children():
            trv.delete(row)
        cursor.execute(f"SELECT * FROM {tabel}")
        for rand in cursor.fetchall():
            trv.insert("", END, values=rand)

    reincarca()

    entries = {}
    frame_formular = Frame(win)
    frame_formular.place(x=20, y=270)
    for i, col in enumerate(coloane):
        Label(frame_formular, text=col).grid(row=0, column=i)
        ent = Entry(frame_formular, width=15)
        ent.grid(row=1, column=i)
        entries[col] = ent

    def adauga():
        valori = [entries[c].get() for c in coloane]
        if not all(valori):
            messagebox.showwarning("Eroare", "Completează toate câmpurile.")
            return
        try:
            q = f"INSERT INTO {tabel} VALUES ({','.join(['%s'] * len(coloane))})"
            cursor.execute(q, valori)
            conexiune.commit()
            reincarca()
            for e in entries.values():
                e.delete(0, END)

                #trigger
        except Exception as e:
            if "Șoferul este deja alocat" in str(e):
                messagebox.showerror("Alocare invalidă", "Acest șofer este deja alocat la acest transport.")
            else:
                messagebox.showerror("Eroare SQL", str(e))

    def sterge():
        sel = trv.focus()
        if not sel:
            messagebox.showwarning("Selectează", "Selectează un rând.")
            return
        valori = trv.item(sel)["values"]
        try:
            cursor.execute(f"DELETE FROM {tabel} WHERE {coloane[0]} = %s", (valori[0],))
            conexiune.commit()
            reincarca()
        except Exception as e:
            messagebox.showerror("Eroare SQL", str(e))

    def actualizeaza():
        sel = trv.focus()
        if not sel:
            messagebox.showwarning("Selectează", "Selectează un rând.")
            return
        valori_vechi = trv.item(sel)["values"]
        valori_noi = [entries[c].get() for c in coloane]
        if not all(valori_noi):
            messagebox.showwarning("Eroare", "Completează toate câmpurile.")
            return
        try:
            set_clause = ', '.join([f"{c} = %s" for c in coloane[1:]])
            q = f"UPDATE {tabel} SET {set_clause} WHERE {coloane[0]} = %s"
            cursor.execute(q, valori_noi[1:] + [valori_vechi[0]])
            conexiune.commit()
            reincarca()
            for e in entries.values():
                e.delete(0, END)
        except Exception as e:
            messagebox.showerror("Eroare SQL", str(e))

    def selectare_rand(event):
        sel = trv.focus()
        if not sel: return
        valori = trv.item(sel)["values"]
        for i, col in enumerate(coloane):
            entries[col].delete(0, END)
            entries[col].insert(0, valori[i])

    trv.bind("<<TreeviewSelect>>", selectare_rand)


    Button(win, text="Adaugă", command=adauga, bg="lightgreen").place(x=200, y=520)
    Button(win, text="Șterge", command=sterge, bg="tomato").place(x=400, y=520)
    Button(win, text="Actualizează", command=actualizeaza, bg="lightblue").place(x=600, y=520)



def fereastra_interogari():
    win = Toplevel()
    win.title("Interogări SQL")
    win.geometry("1000x600")
    seteaza_fundal(win, "background.jpg")

    trv = ttk.Treeview(win, show="headings")
    trv.place(x=20, y=120, width=960, height=440)

    def executa(query, col):
        conexiune = conectare_baza_date()
        cursor = conexiune.cursor()
        cursor.execute(query)
        rezultate = cursor.fetchall()

        trv["columns"] = col
        for c in col:
            trv.heading(c, text=c)
            trv.column(c, width=120)

        trv.delete(*trv.get_children())
        for r in rezultate:
            trv.insert("", END, values=r)


    Button(win, text="1. Camioane > 20T", command=lambda: executa("SELECT * FROM Masini WHERE capacitate_tonaj > 20", ["id_masina", "marca", "model", "an_fabricatie", "nr_inmatriculare", "capacitate_tonaj"])).place(x=20, y=20)
    Button(win, text="2. Șoferi cu CE", command=lambda: executa("SELECT * FROM Soferi WHERE categorie_permis = 'CE'", ["id_sofer", "nume", "prenume", "categorie_permis", "data_angajare", "telefon"])).place(x=180, y=20)
    Button(win, text="3. Transporturi > 500km", command=lambda: executa("SELECT * FROM Transporturi WHERE distanta_km > 500", ["id_transport", "data_plecare", "locatie_plecare", "locatie_destinatie", "distanta_km", "tip_marfa"])).place(x=310, y=20)
    Button(win, text="4. Revizii ITP", command=lambda: executa("SELECT * FROM Revizii WHERE tip_revizie = 'ITP'", ["id_revizie", "id_masina", "data_revizie", "tip_revizie", "cost"])).place(x=500, y=20)
    Button(win, text="5. Șoferi înainte de 2020", command=lambda: executa("SELECT * FROM Soferi WHERE YEAR(data_angajare) < 2020", ["id_sofer", "nume", "prenume", "categorie_permis", "data_angajare", "telefon"])).place(x=630, y=20)
    Button(win, text="6. JOIN Șoferi/Alocări", command=lambda: executa("SELECT S.nume, S.prenume, A.status_transport FROM Soferi S JOIN AlocariTransport A ON S.id_sofer = A.id_sofer", ["nume", "prenume", "status_transport"])).place(x=20, y=60)
    Button(win, text="7. JOIN Camion/Revizie", command=lambda: executa("SELECT M.marca, M.model, R.tip_revizie, R.cost FROM Masini M JOIN Revizii R ON M.id_masina = R.id_masina", ["marca", "model", "tip_revizie", "cost"])).place(x=200, y=60)
    Button(win, text="8. Subinterogare Șoferi - Finalizat", command=lambda: executa("SELECT * FROM Soferi WHERE id_sofer IN (SELECT id_sofer FROM AlocariTransport WHERE status_transport = 'Finalizat')", ["id_sofer", "nume", "prenume", "categorie_permis", "data_angajare", "telefon"])).place(x=400, y=60)
    Button(win, text="9. LENGTH nume", command=lambda: executa("SELECT id_sofer, nume, LENGTH(nume) AS lungime_nume FROM Soferi", ["id_sofer", "nume", "lungime_nume"])).place(x=680, y=60)
    Button(win, text="10. COUNT revizii", command=lambda: executa("SELECT tip_revizie, COUNT(*) AS nr_revizii FROM Revizii GROUP BY tip_revizie", ["tip_revizie", "nr_revizii"])).place(x=20, y=100)




    entry_id_camion = Entry(win, width=10)
    entry_id_camion.place(x=460, y=103)




    def afiseaza_cost_revizii():
        id_camion = entry_id_camion.get()
        if id_camion.isdigit():

            query = f"SELECT cost_total_revizii({id_camion}) AS cost_total"

            executa(query, ["cost_total"])
        else:

            messagebox.showerror("Eroare", "Introduceți un ID valid (număr întreg).")


    Button(
        win,
        text="11. Cost revizii camion (ID din casetă)",
        command=afiseaza_cost_revizii
    ).place(x=190, y=100)












    entry_id_camion_proc = Entry(win, width=10)
    entry_id_camion_proc.place(x=840, y=103)


    def afiseaza_revizii_camion():
        id_camion = entry_id_camion_proc.get()  #

        if not id_camion.isdigit():
            messagebox.showerror("Eroare", "Introduceți un ID valid (număr întreg).")
            return

        conexiune = conectare_baza_date()
        cursor = conexiune.cursor()

        cursor.callproc("afiseaza_revizii_camion", [int(id_camion)])


        for result in cursor.stored_results():
            rezultate = result.fetchall()


        coloane = ["id_revizie", "data_revizie", "tip_revizie", "cost"]
        trv["columns"] = coloane
        for c in coloane:
            trv.heading(c, text=c)
            trv.column(c, width=120)

        trv.delete(*trv.get_children())
        for r in rezultate:
            trv.insert("", END, values=r)


    Button(
        win,
        text="12. Revizii camion (ID din casetă)",
        command=afiseaza_revizii_camion
    ).place(x=600, y=100)












fereastra_login = Tk()
fereastra_login.title("Login")
fereastra_login.geometry("1000x600")
seteaza_fundal(fereastra_login, "background.jpg")

Label(fereastra_login, text="Username", font=("Arial", 12)).place(x=430, y=200)
camp_utilizator = Entry(fereastra_login, font=("Arial", 12))
camp_utilizator.place(x=430, y=230, width=140)

Label(fereastra_login, text="Password", font=("Arial", 12)).place(x=430, y=270)
camp_parola = Entry(fereastra_login, font=("Arial", 12), show="*")
camp_parola.place(x=430, y=300, width=140)

Button(fereastra_login, text="Login", font=("Arial", 12), command=login).place(x=470, y=350)

fereastra_login.mainloop()
