# DBgenerator -------------------------------------------------------------

# pacman::p_load(keyring)
# Init DB using credentials data
credenciales <- data.frame(
    user = c('Superuser', 'Admin', 'Aales', 'Aegui', 'Ainhae', 'Akroggy',
             'Aristocrat', 'Ark', 'Arkanoy', 'Bobulol', 'Bogate', 'Byakura',
             'Cordu', 'Cripy', 'Dalaris', 'Dardragon', 'Deathroll', 'Derser',
             'Destiny', 'Dethwatcher', 'Distur', 'Epar', 'Erish', 'Gaude',
             'Griindhouse', 'Gulraz', 'Ibufropeno', 'JoseTrix', 'Kala',
             'Katty', 'Kaz', 'Kenrayo', 'Leiro', 'Lixie', 'Loliripe', 'Lowy',
             'Lyon90', 'Mandarinas', 'Meryna', 'Mugatsu', 'Nai', 'Niebli',
             'Nooj', 'Notnethber', 'Nuks', 'Nysadra', 'Osura', 'Palomero',
             'Paracetelamo', 'Phsyquic', 'Ryxh', 'Sazed', 'Scizor', 'Shamesh',
             'Shiphidos', 'Supare', 'Swarley', 'Tanatos', 'Tirillas', 'Trolemaga',
             'Ursox', 'Virulenta', 'Voodoomed', 'Wonder', 'Zektuk', 'Ñacañuqui'),
    
    password = c('raistlin1640', 'cucharilla', '2~mAYOR~hORSE=', '0~sPOKE~wOULD@',
                 '6.eQUAL.hUMAN~','0~cROWD~lOWER!','8~mUSIC~oTHER@','3+sTORY+wHILE*',
                 '3_sORRY_tOTAL*','1-sOUTH-eARTH|','2=yOUNG=fIFTY?', '2_wHOSE_pLUTO|',
                 '3|pRESS|sHOWN+','9*dRINK*cLOTH+','6_fOUND_mUSIC@','2-pLACE-qUIET!',
                 '3+cROPS+cOAST=','1_yOUNG_sOUND:','8+fIFTY+oUTER+','9_pLUTO_cHINA!',
                 '7+rADIO+dEATH+','4_kENYA_lABOR%','6,tHOSE,pROVE*','0_gREAT_bEGAN:',
                 '0-gROWN-sHOUT+','1_pLUTO_tEACH=','3*mARCH*tHERE^','3=pRESS=sPACE*',
                 '4+eQUAL+pARIS~','2+uSUAL+hOURS~','8=gROUP=pLANT=','5-aBOVE-aGAIN*',
                 '1~sIGHT~sTORE*','1|qUEEN|fRUIT=','1.pRESS.eVERY^','6_hONOR_pLAIN@',
                 '1,fOUND,cLEAR?','4_wOMEN_wOMAN:','5=sORRY=uNDER!','8-fORTY-cLOCK$',
                 '5.mALTA.sPOKE&','3*tHICK*tRAIN&','3~cOLOR~fRESH^','7+mAYBE+fORCE+',
                 '6=cONGO=aBOVE@','7*nERVE*hUMAN!','9|pOWER|lEAVE=','2+bELOW+fOUND|',
                 '5~tHANK~hURRY$','3-sOUTH-tHESE^','9.cOULD.pROVE~','2*sMELL*tABLE+',
                 '0*hEARD*sCORE!','0=nORTH=bROKE@','1~rAISE~qUITE%','8_wHOSE_eNJOY+',
                 '0|aBOUT|vOWEL^','9~eNEMY~sPACE+','5=mUSIC=eGYPT:','2-pARIS-fAVOR~',
                 '2+uNTIL+pLACE:','3|tHANK|vALUE$','2-sTORM-bONES*','4~sLEPT~bEING^',
                 '8*gROUP*fIFTH=','3|eIGHT|sHARE~'),
    admin = c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
              FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
              FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
              FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
              FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
              FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
              FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE),
    stringsAsFactors = F
)

# you can use keyring package to set database key
# keyring::key_set("R-shinymanager-key", "raistlinmajere")

# Init the database
shinymanager::create_db(
    credentials_data = credenciales,
    sqlite_path = "database.sqlite")
# , # will be created
    # passphrase = key_get("R-shinymanager-key", "raistlinmajere")
    # passphrase = "passphrase_wihtout_keyring"
# )
