# VARIABLES DE COULEUR
$COLORERROR = "Red"
$COLORSUCCESS = "Green"

# FONCTION DE PAUSE PERSONNALISEE
function PAUSE-CUSTOM {
    Write-Host ""
    Read-Host "APPUYE SUR ENTREE POUR CONTINUER..."
}

# FONCTION D'AFFICHAGE DE TITRE UNIFORME
function WRITE-TITLE ($TEXT) {
    Clear-host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "         SCRIPT OUTILS WINDOWS RAPIDE 
                BY LIAM" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
}

# ==== FONCTIONS D'AFFICHAGE DES MENUS ====

function DISPLAY-MAINMENU {
    Clear-Host
    WRITE-TITLE "SCRIPTING BY LIAM"
    Write-Host "  1. PARE-FEU ET SECURITE"
    Write-Host "  2. RESEAU ET INTERNET"
    Write-Host "  3. SYSTEME"
    Write-Host "  4. FICHIERS"
    Write-Host "  5. PROGRAMMES"
    Write-Host "  6. DIVERS"
    Write-Host ""
    Write-Host "  0. QUITTER"
    Write-Host ""
}

function DISPLAY-FIREWALLMENU {
    Clear-Host
    WRITE-TITLE "PARE-FEU ET SECURITE"
    Write-Host "  1. ACTIVER LE PARE-FEU"
    Write-Host "  2. DESACTIVER LE PARE-FEU"
    Write-Host "  3. AJOUTER UNE REGLE"
    Write-Host "  4. SUPPRIMER UNE REGLE"
    Write-Host "  5. ANALYSE AVEC DEFENDER"
    Write-Host ""
    Write-Host "  0. RETOUR"
    Write-Host ""
}

function DISPLAY-NETWORKMENU {
    Clear-Host
    WRITE-TITLE "RESEAU ET INTERNET"
    Write-Host "  1. TESTER LA CONNEXION"
    Write-Host "  2. VOIR ADRESSE IP"
    Write-Host "  3. OUVRIR GOOGLE"
    Write-Host "  4. VIDER CACHE DNS"
    Write-Host ""
    Write-Host "  0. RETOUR"
    Write-Host ""
}

function DISPLAY-SYSTEMMENU {
    Clear-Host
    WRITE-TITLE "OUTILS SYSTEME"
    Write-Host "  1. INFORMATIONS SYSTEME"
    Write-Host "  2. UPTIME"
    Write-Host "  3. UTILISATION CPU/RAM"
    Write-Host "  4. REDEMARRER LE PC"
    Write-Host ""
    Write-Host "  0. RETOUR"
    Write-Host ""
}

function DISPLAY-FILESMENU {
    Clear-Host
    WRITE-TITLE "GESTION DES FICHIERS"
    Write-Host "  1. CREER DOSSIER"
    Write-Host "  2. CACHER FICHIER"
    Write-Host "  3. AFFICHER FICHIERS CACHES"
    Write-Host ""
    Write-Host "  0. RETOUR"
    Write-Host ""
}

function DISPLAY-PROGRAMSMENU {
    Clear-Host
    WRITE-TITLE "PROGRAMMES"
    Write-Host "  1. LISTER PROGRAMMES"
    Write-Host "  2. TUER UN PROCESSUS"
    Write-Host ""
    Write-Host "  0. RETOUR"
    Write-Host ""
}

function DISPLAY-DIVERSMENU {
    Clear-Host
    WRITE-TITLE "OUTILS DIVERS"
    Write-Host "  1. GENERER MOT DE PASSE"
    Write-Host "  2. FAIRE PARLER L'ORDI"
    Write-Host "  3. AFFICHER DATE ET HEURE"
    Write-Host ""
    Write-Host "  0. RETOUR"
    Write-Host ""
}

# ==== FONCTIONS D'ACTIONS OPERATIONNELLES ====

# PARE-FEU
function ACTIVER-PAREFEU {
    netsh advfirewall set allprofiles state on
    Write-Host "PARE-FEU ACTIVE." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

function DESACTIVER-PAREFEU {
    netsh advfirewall set allprofiles state off
    Write-Host "PARE-FEU DESACTIVE." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

function AJOUTER-REGLE {
    $port = Read-Host "ENTREZ LE PORT"
    New-NetFirewallRule -DisplayName "OUVERTURE PORT $port" -Direction Inbound -LocalPort $port -Protocol TCP -Action Allow
    Write-Host "REGLE AJOUTEE." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

function SUPPRIMER-REGLE {
    $nom = Read-Host "NOM DE LA REGLE A SUPPRIMER"
    Remove-NetFirewallRule -DisplayName $nom
    Write-Host "REGLE SUPPRIMEE." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

function ANALYSE-DEFENDER {
    Start-MpScan -ScanType QuickScan
    Write-Host "ANALYSE DEFENDER DEMARREE." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

# RESEAU
function TESTER-CONNEXION {
    Test-Connection -ComputerName 8.8.8.8 -Count 4 | Format-Table
    PAUSE-CUSTOM
}

function VOIR-IP {
    ipconfig
    PAUSE-CUSTOM
}

function OUVRIR-GOOGLE {
    Start-Process "https://www.google.com"
    Write-Host "GOOGLE OUVERT DANS LE NAVIGATEUR." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

function VIDER-DNS {
    Clear-DnsClientCache
    Write-Host "CACHE DNS VIDE." -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

# SYSTEME
function INFOS-SYSTEME {
    Clear-Host
    WRITE-TITLE "INFORMATIONS SYSTEME"
    systeminfo | more
    PAUSE-CUSTOM
}

function UPTIME {
    Clear-Host
    WRITE-TITLE "UPTIME"
    $uptime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $timespan = (Get-Date) - $uptime
    Write-Host "DERNIER DEMARRAGE : $uptime"
    Write-Host "UPTIME : $([math]::Round($timespan.TotalHours,2)) HEURES"
    PAUSE-CUSTOM
}

function UTILISATION-CPURAM {
    Clear-Host
    WRITE-TITLE "UTILISATION CPU/RAM"
    Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 Name, CPU, PM | Format-Table
    PAUSE-CUSTOM
}

function REDEMARRER {
    Write-Host "REDÉMARRAGE DU PC EN COURS..." -ForegroundColor $COLORSUCCESS
    Restart-Computer
}

# FICHIERS
function CREER-DOSSIER {
    $nom = Read-Host "NOM DU DOSSIER"
    $chemin = Join-Path -Path (Get-Location) -ChildPath $nom
    if (-Not (Test-Path $chemin)) {
        New-Item -ItemType Directory -Path $chemin | Out-Null
        Write-Host "DOSSIER CREE : $chemin" -ForegroundColor $COLORSUCCESS
    }
    else {
        Write-Host "LE DOSSIER EXISTE DEJA." -ForegroundColor $COLORERROR
    }
    PAUSE-CUSTOM
}

function CACHER-FICHIER {
    $fichier = Read-Host "CHEMIN DU FICHIER"
    if (Test-Path $fichier) {
        attrib +h $fichier
        Write-Host "FICHIER CACHE." -ForegroundColor $COLORSUCCESS
    }
    else {
        Write-Host "FICHIER INEXISTANT." -ForegroundColor $COLORERROR
    }
    PAUSE-CUSTOM
}

function AFFICHER-CACHES {
    Clear-Host
    WRITE-TITLE "FICHIERS CACHES"
    dir -Force | Where-Object { $_.Attributes -match "Hidden" } | Format-Table Name, LastWriteTime
    PAUSE-CUSTOM
}

# PROGRAMMES
function LISTER-PROGS {
    Clear-Host
    WRITE-TITLE "PROGRAMMES INSTALLES"
    Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Format-Table -AutoSize
    PAUSE-CUSTOM
}

function TUER-PROCESS {
    $nom = Read-Host "NOM DU PROCESSUS (ex: notepad)"
    if (Get-Process -Name $nom -ErrorAction SilentlyContinue) {
        Stop-Process -Name $nom -Force
        Write-Host "PROCESSUS TUE." -ForegroundColor $COLORSUCCESS
    }
    else {
        Write-Host "PROCESSUS NON TROUVE." -ForegroundColor $COLORERROR
    }
    PAUSE-CUSTOM
}

# DIVERS
function GENERER-MDP {
    $mdp = -join ((33..126) | Get-Random -Count 12 | ForEach-Object {[char]$_})
    Write-Host "MOT DE PASSE GENERE : $mdp" -ForegroundColor $COLORSUCCESS
    PAUSE-CUSTOM
}

function PARLER {
    $texte = Read-Host "ENTREZ LE TEXTE A DIRE"
    Add-Type -AssemblyName System.Speech
    (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak($texte)
    PAUSE-CUSTOM
}

function DATE-HEURE {
    Clear-Host
    WRITE-TITLE "DATE ET HEURE ACTUELLES"
    Get-Date
    Write-Host ""
    PAUSE-CUSTOM
}

# ==== GESTION DES SOUS-MENUS ====

function FIREWALLMENU {
    while ($true) {
        DISPLAY-FIREWALLMENU
        $fwChoice = (Read-Host "CHOISISSEZ UNE OPTION PARE-FEU").Trim()
        switch ($fwChoice) {
            "1" { ACTIVER-PAREFEU }
            "2" { DESACTIVER-PAREFEU }
            "3" { AJOUTER-REGLE }
            "4" { SUPPRIMER-REGLE }
            "5" { ANALYSE-DEFENDER }
            "0" { return }
            default { Write-Host "CHOIX INVALIDE" -ForegroundColor $COLORERROR; PAUSE-CUSTOM }
        }
    }
}

function NETWORKMENU {
    while ($true) {
        DISPLAY-NETWORKMENU
        $netChoice = (Read-Host "CHOISISSEZ UNE OPTION RESEAU").Trim()
        switch ($netChoice) {
            "1" { TESTER-CONNEXION }
            "2" { VOIR-IP }
            "3" { OUVRIR-GOOGLE }
            "4" { VIDER-DNS }
            "0" { return }
            default { Write-Host "CHOIX INVALIDE" -ForegroundColor $COLORERROR; PAUSE-CUSTOM }
        }
    }
}

function SYSTEMMENU {
    while ($true) {
        DISPLAY-SYSTEMMENU
        $sysChoice = (Read-Host "CHOISISSEZ UNE OPTION SYSTEME").Trim()
        switch ($sysChoice) {
            "1" { INFOS-SYSTEME }
            "2" { UPTIME }
            "3" { UTILISATION-CPURAM }
            "4" { REDEMARRER }
            "0" { return }
            default { Write-Host "CHOIX INVALIDE" -ForegroundColor $COLORERROR; PAUSE-CUSTOM }
        }
    }
}

function FILESMENU {
    while ($true) {
        DISPLAY-FILESMENU
        $fileChoice = (Read-Host "CHOISISSEZ UNE OPTION FICHIERS").Trim()
        switch ($fileChoice) {
            "1" { CREER-DOSSIER }
            "2" { CACHER-FICHIER }
            "3" { AFFICHER-CACHES }
            "0" { return }
            default { Write-Host "CHOIX INVALIDE" -ForegroundColor $COLORERROR; PAUSE-CUSTOM }
        }
    }
}

function PROGRAMSMENU {
    while ($true) {
        DISPLAY-PROGRAMSMENU
        $progChoice = (Read-Host "CHOISISSEZ UNE OPTION PROGRAMMES").Trim()
        switch ($progChoice) {
            "1" { LISTER-PROGS }
            "2" { TUER-PROCESS }
            "0" { return }
            default { Write-Host "CHOIX INVALIDE" -ForegroundColor $COLORERROR; PAUSE-CUSTOM }
        }
    }
}

function DIVERSMENU {
    while ($true) {
        DISPLAY-DIVERSMENU
        $divChoice = (Read-Host "CHOISISSEZ UNE OPTION DIVERS").Trim()
        switch ($divChoice) {
            "1" { GENERER-MDP }
            "2" { PARLER }
            "3" { DATE-HEURE }
            "0" { return }
            default { Write-Host "CHOIX INVALIDE" -ForegroundColor $COLORERROR; PAUSE-CUSTOM }
        }
    }
}

# ==== BOUCLE PRINCIPALE ====

while ($true) {
    DISPLAY-MAINMENU
    $choice = (Read-Host "FAIS TON CHOIX").Trim()
    switch ($choice) {
        "1" { FIREWALLMENU }
        "2" { NETWORKMENU }
        "3" { SYSTEMMENU }
        "4" { FILESMENU }
        "5" { PROGRAMSMENU }
        "6" { DIVERSMENU }
        "0" {
            Write-Host "AU REVOIR !" -ForegroundColor $COLORSUCCESS
            return
        }
        default {
            Write-Host "CHOIX INVALIDE, REESSAYE." -ForegroundColor $COLORERROR
            PAUSE-CUSTOM
        }
    }
}