USE mydb;   

/* • Ažuriranje budžeta u slučaju dodatog troška projekta
    • Ažuriranje ukupnog broja prisutnih na projektu */

delimiter #
    
create trigger bi_trosak
before insert on Trosak
for each row
begin
    if (
        select budzet
        from Projekat 
        where Projekat_id_projekta = id_projekta
    ) > iznos
    then update Projekat set budzet = budzet - iznos;
    else
        signal sqlstate '45000' set message_text='Nedozvoljen unos';
    end if;
end
#

create trigger ai_ucestvovanje
after insert on Ucestvovanje
for each row
begin
    update Projekat set br_ucesnika = br_ucesnika + 1 where Projekat_id_projekta = id_projekta;
end
#

create trigger ai_podrzava
after insert on Podrzava
for each row
begin
    update Projekat set br_ucesnika = br_ucesnika + 1 where Projekat_id_projekta = id_projekta;
end
#

create trigger ai_volontiranje
after insert on Volontiranje
for each row
begin
    update Projekat set br_ucesnika = br_ucesnika + 1 where Projekat_id_projekta = id_projekta;
end
#

create trigger bd_ucestvovanje
before delete on Ucestvovanje
for each row
begin
    if (
        select br_ucesnika
        from Projekat
        where Projekat_id_projekta = id_projekta
    ) > 0
    then
        update Projekat set br_ucesnika = br_ucesnika - 1 where Projekat_id_projekta = id_projekta;
    else
        signal sqlstate '45000' set message_text='Nedozvoljen unos';
    end if;
end
#

create trigger bd_volontiranje
before delete on Volontiranje
for each row
begin
    if (
        select br_ucesnika
        from Projekat
        where Projekat_id_projekta = id_projekta
    ) > 0
    then
        update Projekat set br_ucesnika = br_ucesnika - 1 where Projekat_id_projekta = id_projekta;
    else
        signal sqlstate '45000' set message_text='Nedozvoljen unos';
    end if;
end
#

create trigger bd_podrzava
before delete on Podrzava
for each row
begin
    if (
        select br_ucesnika
        from Projekat
        where Projekat_id_projekta = id_projekta
    ) > 0
    then
        update Projekat set br_ucesnika = br_ucesnika - 1 where Projekat_id_projekta = id_projekta;
    else
        signal sqlstate '45000' set message_text='Nedozvoljen unos';
    end if;
end
#

delimiter ;
