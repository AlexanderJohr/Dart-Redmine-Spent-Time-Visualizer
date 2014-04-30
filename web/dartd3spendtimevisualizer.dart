import 'dart:html';
import 'spend_time_visualizer/spend_time_visualizer.dart';
import 'dart:svg';



import 'package:js/js.dart' as js;



void main() {

String csvText=
'''
Projekt;Datum;Benutzer;Aktivität;Ticket;Kommentar;Stunden;Sequencing
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-23;Christopher Helmbold;Development;Task #285084: Merkzettel-Bearbeitung;14-16 Uhr - Versucht Merkzettel zu Optimieren - RemoveFromNotice hinzugefügt;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-18;Tony Baumann;Development;Task #284576: Meetings;"";28,05;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-17;Christian Kusan;Development;Task #241578: LibovExport;"11:00-11:30 Uhr; Bugfix Export behoben, Caching deaktiviert (ich hoffe es..), Schrift in der Textbox zentriert; Text aus der Zwischenablage ignorieren";0,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-17;Christian Kusan;Development;Task #233102: Libov;"10:00-10:30; Rücksprache mit Frau Peters: Musterkennung der Regale";0,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-17;jerome bettin;Development;Task #286623: Datenbanken Anbindung;14:45 - 19:45 Lazy Loading neu performanter programmiert.;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-16;jerome bettin;Development;Task #287246: USB ;"11:30 - 13:30; Abfrage nach freien speicher auf dem usb stick";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-16;Christoph Schulze;Planning;Task #284576: Meetings;"";32,25;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-16;Alexander Johr;Development;Task #286623: Datenbanken Anbindung;14:45 - 19:45 Lazy Loading neu performanter programmiert.;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-16;Stefan Ehrhardt;Development;Task #291958: Präsentation für Meeting;Präsentation erstellt;0,75;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-16;Stefan Ehrhardt;Design;Task #287381: Weiterführung Entwürfe;Entwurf erweitert und möglichen Benutzervorgang simuliert.;12,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-15;Christian Kusan;Development;Task #233102: Libov;"21-23 Uhr; Background-Image setzen (per FileUpload), Bugfixing (Kontextmenü; Hintergrundbild, ...); akt. Problem: Hintergrundbild soll nach Import immer noch verfügbar sein";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-14;Christopher Helmbold;Development;Task #293533: Merkzettel aufbereitet;"";7,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-14;Christian Kusan;Development;Task #290821: Libov Import;"22-24 Uhr; JavaScript-Import erfolgreich, Bugfixing (Parser, Kontextmenü)";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-14;jerome bettin;Development;Task #287246: USB ;"12:00 -15:00 Uhr; PDF auf USB stick schreiben; momentan per File.Copy(); da der Streamwriter in C# die PDF beschädigt hat ";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-14;Christian Kusan;Development;Task #285084: Merkzettel-Bearbeitung;"12:40-17:10 Uhr; Aktualisierung Merkzettel (Anpassung an neue Objekte), Versuch Bücher auf Notizzettel-Oberfläche sichtbar zu machen";4,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-13;Christian Kusan;Development;Task #290821: Libov Import;"22-4:30 Uhr; XAML-Parser mit PHP und Konvertierung zu JavaScript-Code (akt. Problem: JS-Code wird nicht ausgeführt, obwohl nicht fehlerhaft)";6,30;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-12;Christian Kusan;Development;Task #233102: Libov;"19-22 Uhr; Regex für Musterkennung / Überprüfung ";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-10;jerome bettin;Development;Task #287246: USB ;"11:00 - 13:00; Recherche USB rechte Vergabe, nur write; Autoplay abschalten Windows, Ergebnis Gast User mit eingeschrenkten rechten ";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-10;jerome bettin;Development;Task #286623: Datenbanken Anbindung;"11:30 - 14:30; 15:30 - 17:30; Anbindung Springer Link als Observable Collection. Styledefinition über Datatrigger zeigen selektierte Bücher an.";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Christian Kusan;Development;Task #233102: Libov;"23-4 Uhr; Umsortierung der UI, Validator, Bugfixes";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Alexander Johr;Development;Task #286623: Datenbanken Anbindung;"11:30 - 14:30; 15:30 - 17:30; Anbindung Springer Link als Observable Collection. Styledefinition über Datatrigger zeigen selektierte Bücher an.";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Stefan Ehrhardt;Planning;Task #287559: Teammeetings;"";1,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Stefan Ehrhardt;Planning;Task #289508: 3D Webbrowser Grundwissen einholen;In diversen Foren gelesen. Auf der Homeseite von Awesomium Code angesehen und SDK heruntergeladen.;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #289452: Stunden Semster 1;"";17,15;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #257843: RADIUS-Server;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250518: Expertengespräche Wlan Triangolie;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250500: Einarbeitung in C#;"";44,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250491: Redmin Einarbeitung;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250492: SVN einrichten;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250493: Machbarkeitsstudie;"";7,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250495: Projektplanung nach DIN  69901-1/5;"";17,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250496: Versuch UML-Einzuführen;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250501: Einarbeitung in Visual Studio 2012;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250503: Team Administration;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250507: Radius Prototyp;"";14,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250508: Wifi Direct Prototyp;"";13,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250509: RFID Treiber ;"";4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250511: Tutorial SVN;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-09;Herbert  Schwakowiak;Development;Task #250513: Wiki bearbeiten;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-08;Stefan Ehrhardt;Planning;Task #289509: 3D Webbrowser Visual Studio besorgt;gesucht und gefunden;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-04;Christoph Schulze;Development;Task #282209: Touch Points Scroll Resize;Ausprobieren von lösungsansätzen;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-03;Martin Kunze;Development;Task #287354: GUI: Neuauflage;"Implementierungsgrundlagen (Rotierendes Kreismenue) (3.4.14; 11:30 - 15:00)";3,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-03;Martin Kunze;Design;Task #287381: Weiterführung Entwürfe;Entwicklung des UI-Aufbaus auf Grundlage eines Kreismenüs;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-03;jerome bettin;Development;Task #278079: Virtuelle Tastatur;"15:40 - 18:10; WM-Points in der Tastatur benutzen anstelle der WM-Gestugre da diese nur für 2 touchpunkte sind";2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-03;Stefan Ehrhardt;Design;Task #287381: Weiterführung Entwürfe;Entwicklung des UI-Aufbaus auf Grundlage eines Kreismenüs;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-02;Stefan Ehrhardt;Development;Task #287381: Weiterführung Entwürfe;Entwurf#1 finalisiert (präsentierbar/diskutierbar);6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-02;Stefan Ehrhardt;Administrative;Task #287559: Teammeetings;"";1,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-02;Alexander Johr;Development;Task #278079: Virtuelle Tastatur;15:30 - 18:00;2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-02;jerome bettin;Development;Task #287246: USB ;"11:30 - 14:00; USB Stick laufwerkebuchstaben und name anzeigen für die Abfrage, Laufwerk funktioniert, name des USB stick noch nicht";2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-02;jerome bettin;Development;Task #284576: Meetings;"";29,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-02;Uwe Genowa;Development;Task #282209: Touch Points Scroll Resize;Custom Containers erstellt - Test folgt;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-01;Christian Kusan;Development;Task #290821: Libov Import;"23-3 Uhr; Libov-Import mit PHP";4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-01;Christian Kusan;Development;Task #285084: Merkzettel-Bearbeitung;17-20 Uhr, Beginn Einbindung von Libov;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-04-01;Alexander Johr;Development;Task #286623: Datenbanken Anbindung;"16:30 - 17:30; Gespräch mit Alexander Lausmann, Untersuchung WTO e-Library";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-31;jerome bettin;Development;Task #287246: USB ;"14:00 - 16:00; program1 erkennt alle USB devices und Hubs auf dem rechner und gibt sie auf der Konsole aus, Programm 2 erkennt das an und abmelden des Usb sticks mit laufwerkbuchstaben";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-31;jerome bettin;Development;Task #286623: Datenbanken Anbindung;"15:30 - 18:00; mit Herrn Johr CSV Parser für Springer Link";2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-31;Christian Kusan;Development;Task #285084: Merkzettel-Bearbeitung;16-20 Uhr, Versuche mit dem DataGrid-Layout, leider noch nicht zufriedenstellend;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-31;Alexander Johr;Development;Task #286623: Datenbanken Anbindung;"15:30 - 18:00; Mit Jerome zusammen CSV Parser für Springer Link erstellt";2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-28;Christian Kusan;Development;Task #233102: Libov;"1-6 Uhr; Libov-Erweiterung (copy, delete, setContent, ...) und Bugfixes (marker); Anpassung an weitere Browser (IE, Firefox, Chrome)";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-28;jerome bettin;Development;Task #287246: USB ;09:00- 10:00 Einarbeitung USB c#/Windows  ;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-28;Uwe Genowa;Development;Task #284576: Meetings;Anweseheit - wöchentliche Meetings;22,25;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-28;Christopher Helmbold;Development;Task #285084: Merkzettel-Bearbeitung;21 - 23 Uhr Einbau und Aktualisierung neuer Methoden, Recherche bezüglich Grid Aktualisierung;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-27;Christoph Schulze;Development;Task #282210: Bluetooth;Bluetooth suche in Thread laufen lassen;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Christian Kusan;Development;Task #241578: LibovExport;"5-8 Uhr; Arbeit mit dem DOM-Parser von PHP";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Stefan Ehrhardt;Administrative;Task #284576: Meetings;"";29,05;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Christopher Helmbold;Development;Task #285084: Merkzettel-Bearbeitung;15-18 Uhr, UI Button Aktualisierung;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Christian Kusan;Development;Task #285084: Merkzettel-Bearbeitung;15-18 Uhr, 21-22 Uhr: SortBy, UI, Klassen-Upgrading;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Christian Kusan;Development;Task #285084: Merkzettel-Bearbeitung;11-13 Uhr, 15-19 Uhr - Manager, XML (read, write), Notice;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Christian Kusan;Development;Task #284576: Meetings;Meetings Semester 1;32,25;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Alexander Johr;Development;Task #284576: Meetings;Anwesenheit zu Jahresprojekt Mittwochstreffen im WiSe2013/14;32,42;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Martin Kunze;Development;Task #284576: Meetings;Martin Kunze, Anwesenheit im WiSe 13/14;25,17;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-26;Christopher Helmbold;Development;Task #284576: Meetings;Anwesendheitstunden von Christopher Helmbold;32,25;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-25;Christopher Helmbold;Development;Task #285084: Merkzettel-Bearbeitung;11-13 Uhr, 15-19 Uhr - Vorbereitung der Notice Klasse für Manager;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-25;Christian Kusan;Development;Task #284576: Meetings;14-15 Uhr, Bibliothekskommission;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-25;Alexander Johr;Development;Task #284576: Meetings;14:00 - 15:00 Bibliothels-Kommision;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-25;Christopher Helmbold;Development;Task #284237: Analyse Zwischenstand und Anforderungsanalyse;15-19 Uhr mit Herrn Kusan;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-24;Tony Baumann;Administrative;Task #283636: Einladung + Agenda;Einladung ist raus;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-23;Uwe Genowa;Development;Task #282210: Bluetooth;Bluetoothverbindung in das Projekt Integriert;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;Christian Kusan;Development;Task #241578: LibovExport;"12-13 Uhr; Zwischenstands-Analyse (White-Box-Testing), Parsing mit PHP";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;Stefan Ehrhardt;Administrative;Task #287559: Teammeetings;"";1,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;jerome bettin;Development;Task #282288: Datenbanken Anbindung IEEE;"14:30 - 16:00; die richtige CSV Datei vom IEEE bekommen";1,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;jerome bettin;Development;Task #282288: Datenbanken Anbindung IEEE;12:00 - 14:00 Mit Herrn Johr versucht einen CSV vom IEEE zubekommen in der die richtigen Suchanfragen ;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;Christian Kusan;Development;Task #284237: Analyse Zwischenstand und Anforderungsanalyse;15-19 Uhr, Anforderungsanalyse;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;Alexander Johr;Development;Task #282209: Touch Points Scroll Resize;15:00 - 18:00 Projekte gesäubert und neu commited.;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-19;Alexander Johr;Development;Task #282288: Datenbanken Anbindung IEEE;"12:00 - 14:00 Mit Jerome zusammen die POST Header für IEEE Export Results analasiert; Noch kein Erfolg. Es werden immer alle 2000 Suchergebnisse geliefert, die nicht angefragt wurden.";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-16;Christian Kusan;Development;Task #279154: Korrekturlesen und Strukturierung;12:45-19:15 Uhr, letztes Korrekturlesen;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-15;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;13:00 - 0:30;11,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-14;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;"12:00 - 13:00;  16:00 - 19:00; 21:00 -  1:00; Übertragen der Hälfte des Redmine-Wiki in ein Latex-Dokument";8,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-14;Stefan Ehrhardt;Development;Task #257845: Corporate Design;Dokumentation erstellt;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-14;Christian Kusan;Development;Task #279154: Korrekturlesen und Strukturierung;3:15-6:30, Sichtung/Korrektur/Formatierung/Strukturierung - Dokumente von Alex L;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-14;Christian Kusan;Development;Task #279154: Korrekturlesen und Strukturierung;1:30-3:30 Uhr, Korrektur und Formatierung der Texte von A. Johr;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-13;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;11:00 - 20:45 Korrekturlesen der Artikel Shibboleth, Datenbankanbindung und Anzeigen von Ebooks in WPF;20,75;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-12;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;11:00 - 17:00  Recherche Doku Shibboleth;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-11;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;"12:00 - 21:30; Recherche Doku Shibboleth";9,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-11;Christian Kusan;Development;Task #279154: Korrekturlesen und Strukturierung;20:18-22:38 Uhr;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-10;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;"14:00 - 19:00; Recherche und Doku Shibboleth";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-09;Christian Kusan;Development;Task #279156: Meilensteine & Ticketstrukturierung;9.3.: 22:30-23 Uhr, 11.3.: 1:20- 1:50 Uhr;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-09;Alexander Johr;Development;Task #278039: Ersetzung von PdfBox durch Ghostscript.net;11:30 - 20:30 Vollständige Ersetzung von PdfBox durch Ghostscript.Net, Kein JNI mehr nötig (Projekt wurde gelöscht), PdfBox entfernt, Wrapper Java Klasse entfernt. Generieren der Bilder läuft im eigenen Thread und stoppt die Hauptanwendung nicht;9,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-08;Alexander Johr;Development;Task #278039: Ersetzung von PdfBox durch Ghostscript.net;15:00 - 18:00 Anf#ngliche Arbeiten zum ersetzen von PdfBox durch Ghostscript.Net. Tests, erstes Schreiben von Bildern auf die Festplatte;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-03-07;Alexander Johr;Development;Task #257821: Abschlussbericht erstellen;"19:00 - 24:00 Dokumentation der Anzeige der Pdf-Dateien innerhalb von WPF; Dokumentiert: MoonPdf, Windows Forms Host, XPS Writer, PdfBox, Ghostscript.Net";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-27;Christian Kusan;Development;Task #238030: Wikibearbeitung;20-21:30 Uhr;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-27;Christian Kusan;Development;Task #241578: LibovExport;18-19 Uhr, Export mit JavaScript;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-23;Tony Baumann;Development;Task #257836: Projektplan;PSP neu aufbereitet;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-22;Christian Kusan;Development;Task #233102: Libov;17-18 Uhr, bugfixes;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-22;Christian Kusan;Development;Task #241578: LibovExport;19-20 Uhr, HTMLParser mit Python zum Laufen gebracht;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-21;Tony Baumann;Planning;Task #257836: Projektplan;Zusammenfassung als PDF;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-21;Uwe Genowa;Development;Task #257847: WPF Breeze Multitouch;Doku erstellt;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-21;Martin Kunze;Development;Task #257832: WISO;Am 19.02.2014 - 22:00 Uhr bis 24:00 Uhr;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-20;Christian Kusan;Development;Task #233102: Libov;"12-14, 16-18, 21-22 Uhr; Bug-Bekämpfung";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-20;Alexander Johr;Planning;Task #271806: Recherche Anzeige PDF in WPF (NuGet Packet Ghostscript.Net);"22:00 - 02:00;";4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-19;Christian Kusan;Development;Task #257822: Libov;16-18 Uhr;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-02-19;Christoph Schulze;Development;Task #251786: Feature-Liste für Präsentation;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-01-06;jerome bettin;Development;Task #254828: Inhalt Präsentation zusammenfassen;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-01-06;jerome bettin;Development;Task #254825: Personas;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2014-01-06;jerome bettin;Development;Task #254827: Multifocustastatur;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Christoph Schulze;Development;Task #251790: Jahrespräsentation vorbereiten;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Christoph Schulze;Development;Task #251783: Juris-Anbindung;"";15,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Christoph Schulze;Development;Task #251780: Entwicklung eines WLAN Direkt Prototypen;"";18,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Christoph Schulze;Development;Task #251778: Recherche zu WLAN Direkt;"";9,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Christoph Schulze;Development;Task #251777: NFC Pro­to­typ erstellen;"";21,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Christoph Schulze;Development;Task #251772: Einarbeitung in NFC Programmieren;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-21;Alexander Johr;Development;Task #251673: eBook Vorschau;17:30 - 01:45;8,25;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-20;Alexander Johr;Development;Task #251337: Recherche / Anbindung Datenbanken;0:00 - 4:00 Recherche für IEEE, Benoetigt Cookies, benoetigt User-Agent Angabe;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-18;Alexander Johr;Development;Task #250450: Bibliothekskommission - Vorstellung;13:30 - 15:30;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-11;Christian Kusan;Development;Task #253940: Zwischenpräsentation;Präsentation am 11.12.13;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-11;Alexander Johr;Development;Task #241513: Jahrespräsentation vorbereiten;8:00 - 11:00 Zwischenpräsentation;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-10;Christian Kusan;Development;Task #253940: Zwischenpräsentation;s. Task-Beschreibung;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-10;Alexander Johr;Development;Task #241513: Jahrespräsentation vorbereiten;15:00 - 17:00 Probe vor der Zwischenpräsentation mit Table;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-03;Alexander Johr;Development;Task #241513: Jahrespräsentation vorbereiten;16:00 - 22:00 Stichpunkte und Prezi vorbereitet;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-02;Alexander Johr;Development;Task #241513: Jahrespräsentation vorbereiten;13:00 - 16:30 Stichpunkte und Prezi vorbereitet;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-02;Alexander Johr;Development;Task #241513: Jahrespräsentation vorbereiten;"13:30 - 17:00; Stichpunkte gekürzt, diverse Screenshots erstellt, auf Dropbox hochgeladen und verlinkt, neues Design in XAML umgewandelt";3,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-12-01;Tony Baumann;Development;Task #244249: Feature-Liste für Präsentation;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-29;jerome bettin;Development;Feature #243539: Tetrus;Tetris Clon;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-29;jerome bettin;Development;Task #243522: TUIO/Touch  Java;"";13,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-29;jerome bettin;Development;Task #232372: Theoretische Informatik Entwurf;Implementierung ;10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-29;jerome bettin;Planning;Task #232370: Lernsoftware;Konkurenzanalyse und Entwurf;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-28;Martin Kunze;Development;Task #241785: Anbindung an WISO und Juris - Versuch;10:30 - 13:30;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-27;Christian Kusan;Development;Task #244001: Inhalt zusammentragen - C. Kusan;13:00-15:00;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-27;Martin Kunze;Development;Task #241785: Anbindung an WISO und Juris - Versuch;11:30 - 13:00;1,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-26;Martin Kunze;Development;Task #241785: Anbindung an WISO und Juris - Versuch;15:00 - 18:30;3,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-26;Alexander Johr;Development;Task #242519: Science Slam - A. Johr;"13:00 - 15:00; Vorbereitung/Feinschliff Cybrary für Science Slam; 15:00-19:00 Uhr Beaufsichtigung und Präsentation des akt. Projektstandes";6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-26;Christian Kusan;Development;Task #242477: Science Slam - C. Kusan;15:00-19:00 Beaufsichtigung und Präsentation des akt. Projektstandes;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-26;Martin Kunze;Development;Task #229878: Anbindung an WISO;Läuft immer noch nicht;10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-26;Martin Kunze;Development;Task #232377: Learning C#;"";15,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Martin Kunze;Development;Task #241785: Anbindung an WISO und Juris - Versuch;12:00 - 18:00;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Alexander Johr;Development;Task #238208: Lösung für schlechten PDF Viewer finden;"15:00-17:00; 20:30-21:30";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Christian Kusan;Development;Task #241578: LibovExport;Dokumentation für JavaScript mit Doxygen und Eintrag ins Wiki;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Stefan Ehrhardt;Development;Task #229759: Logo;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Christopher Helmbold;Development;Task #241562: Merkzettel für Cybrary;"";4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Christopher Helmbold;Development;Task #240779: Recherche Drag and Drop in Visual Studio ;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-25;Christopher Helmbold;Development;Task #237454: Bluetooth in Windows Phone und iPhone;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-24;Christian Kusan;Development;Task #241578: LibovExport;Versuch html5lib einzubinden, Ausweichen auf Python;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-24;Alexander Johr;Development;Task #241560: Virtuelle Tastatur einbinden;20:30 - 22:00  WPF Touch Screen Keyboard eingebunden, Nicht eingecheckt da das Ergebnis nicht erzielt wurde.;1,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-24;Alexander Johr;Development;Support #241537: Kommunikation / Klären / Schlichten / Beraten;19:15 - 20:15;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-24;Alexander Johr;Development;Support #241537: Kommunikation / Klären / Schlichten / Beraten;16:30 - 18:30;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-23;Tony Baumann;Development;Task #242551: Juris-Anbindung;"";25,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-23;Christian Kusan;Development;Task #241578: LibovExport;Google Dart - Datei einlesen;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-22;Martin Kunze;Development;Task #241785: Anbindung an WISO und Juris - Versuch;Den ganzen Tag verteilt von 9:00 an bis abends (zwischendurch war Vorlesung und so...);9,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-22;Stefan Ehrhardt;Development;Task #240643: GUI Entwurf: digitale Umsetzung;"";30,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-21;Martin Kunze;Development;Task #241785: Anbindung an WISO und Juris - Versuch;18:00 - 20:00;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-21;Alexander Johr;Development;Task #238208: Lösung für schlechten PDF Viewer finden;19 -22;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-21;Stefan Ehrhardt;Development;Task #229772: Projektname;trinamics / trinamix;10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-21;Christian Kusan;Development;Task #238030: Wikibearbeitung;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-21;Christian Kusan;Development;Task #238030: Wikibearbeitung;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-20;Christian Kusan;Development;Task #233102: Libov;"00:00-01:00 Uhr; es gab leider Probleme mit Google Dart (Einbindung dart:io)";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-20;Alexander Johr;Development;Task #238208: Lösung für schlechten PDF Viewer finden;19:00 - 03:00;8,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-20;Martin Kunze;Development;Task #232377: Learning C#;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-19;Alexander Johr;Development;Task #238208: Lösung für schlechten PDF Viewer finden;18 - 03:30;9,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-17;Christian Kusan;Development;Task #233102: Libov;11:00-18:00 Uhr;7,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-16;Christian Kusan;Development;Task #233102: Libov;14:00-19:00 Uhr;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-14;Alexander Johr;Development;Task #238208: Lösung für schlechten PDF Viewer finden;16-22;6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-11;Christian Kusan;Development;Task #233102: Libov;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-11-09;Martin Kunze;Development;Task #232377: Learning C#;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-31;Alexander Johr;Development;Task #233037: Alexander Johr: Projektplanungstreffen;15:00 - 18:00;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-31;Christian Kusan;Development;Task #230404: Kusan: Projektplanung / Erstellung des Pflichtenheftes;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-30;Martin Kunze;Development;Task #232377: Learning C#;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-30;Uwe Genowa;Development;Task #232375: Einarbeitung C# und WPF;"";15,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-30;Tony Baumann;Development;Task #232283: Pflichtenheft;"";2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-29;Christian Kusan;Development;Task #233102: Libov;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-28;Christian Kusan;Development;Task #233102: Libov;"";7,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-27;Christian Kusan;Development;Task #233102: Libov;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-26;Christian Kusan;Development;Task #233102: Libov;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-25;Christian Kusan;Development;Task #230543: Kusan: IPhone Bluetooth Test ;13:00-15:00;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-25;Christian Kusan;Development;Task #221180: Einarbeitung in TUIO zusammen mit C++ bzw QT;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-25;Christian Kusan;Development;Task #230846: Bearbeitung Wiki;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-25;Alexander Johr;Development;Task #230545: Johr: IPhone Bluetooth Test ;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-24;Alexander Johr;Development;Task #230404: Kusan: Projektplanung / Erstellung des Pflichtenheftes;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-24;Alexander Johr;Development;Task #230401: Johr: Projektplanung / Erstellung des Pflichtenheftes;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-23;Tony Baumann;Development;Task #230402: Baumann: Projektplanung / Erstellung des Pflichtenheftes;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-23;Uwe Genowa;Development;Task #229878: Anbindung an WISO;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-23;Martin Kunze;Development;Task #229868: Anbindung an Psyndex;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-23;Martin Kunze;Development;Task #229868: Anbindung an Psyndex;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-23;Stefan Ehrhardt;Development;Task #225303: Layout des User Interface: Entwürfe #2;"";20,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-23;Alexander Johr;Development;Task #229752: Scrollen und Verschieben eines Elementes in den Griff bekommen: Erfolg;Fertiggestellt: Von 21:30 - 24:00;2,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-16;Alexander Johr;Development;Task #227534: Integration in Breeze-Framework-Beispiel und PDF-Übertragung;Fertiggestellt. Integration ist durch Einfügen des von Christoph vorbereiteten WinForms-Prototypen einfach gewesen.;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-16;Christopher Helmbold;Development;Task #227458: TUIOPong;"";6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-15;Christian Kusan;Development;Task #225049: Bewertung Qt;19-20 Uhr;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-15;Christian Kusan;Development;Task #225051: Bewertung Kivy;18-19 Uhr;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-14;Christoph Schulze;Development;Task #226314: Bluetooth Prototyp;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-13;Uwe Genowa;Development;Task #222664: MT4j testen und Demo ausprobieren;Getestet - für 64bit OS muessen dll Dateien ausgetauscht werden;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-13;Alexander Johr;Development;Task #227247: Integration eines PDF Readers (MoonPDF);"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-13;Christopher Helmbold;Development;Task #225037: Recherche Finnland;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-12;Alexander Johr;Development;Task #225135: Planung Meilensteine;"";8,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-12;Alexander Johr;Development;Task #225072: Nico Schulz Gestures in TUIO erfragen;Die Verwendete Technologie für das Memoria-Prjekt war MT4J. TUIO sendet nur Touch-Soignale. Die Frameworks (z.b. MT4J) erkennen die Gesten. MT4J eigenete sich für das Projekt, da außer Kreisen für das Spiel nichts benötigt wurde.;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-12;Christopher Helmbold;Development;Task #225039: Unity Bewertung;"";0,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-10;Stefan Ehrhardt;Planning;Task #225307: Interview: Frau Peters;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-09;Christian Kusan;Planning;Task #225375: Interview Frau Peters;14:30-15:30 Uhr;1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-09;Christopher Helmbold;Planning;Task #224786: Einarbeitung in C# und WPF;"";6,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-08;Christoph Schulze;Development;Task #222662: Einarbeitung in C# und WPF;"";10,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-05;Christian Kusan;Planning;Task #221180: Einarbeitung in TUIO zusammen mit C++ bzw QT;18-20 Uhr;2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-05;jerome bettin;Development;Task #222660: In C# und  WPF einarbeiten (Pluralsight);zeit der video tutorials von jörn loviscach;12,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-02;Stefan Ehrhardt;Design;Task #220557: Scribbles des Willkommens- und Desktop-Bildschirms;making some scribbles;3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-10-01;Tony Baumann;Planning;Task #222666: PSP;"";0,50;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-30;Christian Kusan;Planning;Task #221180: Einarbeitung in TUIO zusammen mit C++ bzw QT;20:10-20:40, 21:30-4:40, Ausarbeitung Vorträge Qt + TUIO, Kyvi, Sammeln von Informationen über PyMT, Kyvi, Python;7,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-29;Christian Kusan;Planning;Task #221180: Einarbeitung in TUIO zusammen mit C++ bzw QT;"20:30-21:10, 0:15-0:55; Schwierigkeiten: qTUIO + Qt (Mail an Entwickler), QMTSimulator";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-28;Alexander Johr;Planning;Task #222665: uniTUIO;14:00 - 19:00 Schwierigkeiten: Lizenzprobleme, fehlendes Know How;5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-28;Christian Kusan;Planning;Task #221180: Einarbeitung in TUIO zusammen mit C++ bzw QT;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-28;Stefan Ehrhardt;Planning;Task #220557: Scribbles des Willkommens- und Desktop-Bildschirms;making a plan;4,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-27;Alexander Johr;Development;Task #221211: Redmine Tutorial durcharbeiten / Redmine einrichten;"";2,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-27;Alexander Johr;Development;Task #221205: Team Administration;"";5,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-27;Alexander Johr;Development;Task #221194: Einladung Projekttreffen / Mitglieder informieren;"";1,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-27;Alexander Johr;Development;Task #221186: Kontaktdaten zusammentragen.;"";3,00;""
Cybrary (Jahresprojekt TouchTable HsHarz);2013-09-27;Alexander Johr;Development;Task #221185: Google Drive einrichten;"";3,00;""
''';







  List<CaptionProportionPair> pairs = new List();


  RedmineCsvParser redmineCsvParser = new RedmineCsvParser();
  RedmineData parsedRedmineData = redmineCsvParser.parse(csvText);

  DateTime maxDate = parsedRedmineData.maxDate.add(new Duration(days: 1));
  DateTime minDate = parsedRedmineData.minDate;


  Map<String, RedmineMember> redmineMemberMap = parsedRedmineData.redmineMemberMap;
  List<String> mebmerKeyList = new List.from(redmineMemberMap.keys);
  int mebmerKeyListLength = mebmerKeyList.length;

  for(int iMemberKey = 0; iMemberKey < mebmerKeyListLength; iMemberKey++){

    String currentMemberkey = mebmerKeyList[iMemberKey];
    CaptionProportionPair currentCaptionProportionPair =
        new CaptionProportionPair(currentMemberkey, 0.0);
    pairs.add(currentCaptionProportionPair);

  }

  Element spendTimeVisualizerElement = querySelector('#spend_time_visualizer_chart');




  CaptionProportionPairCollection captionProportionPairCollection =
      new CaptionProportionPairCollection(pairs);


  SpiderChart spiderChart = new SpiderChart(captionProportionPairCollection, 5,800, 800);
  GElement spiderChartGElement = spiderChart.spiderChartGElement;
  spendTimeVisualizerElement.append(spiderChartGElement);


  Map<String, CaptionProportionPair> observableMap =
      captionProportionPairCollection.nonExtendableObservableCaptionProportionPairsMap;


  void calculateChartData(DateTime firstDate, DateTime lastDate){

    for(int iMemberKey = 0; iMemberKey < mebmerKeyListLength; iMemberKey++){

      final String currentMemberkey = mebmerKeyList[iMemberKey];
      final RedmineMember currentMember = redmineMemberMap[currentMemberkey];

      final num currentMemberHours =
          currentMember.getHoursBetweenTwoDates(firstDate, lastDate);

      CaptionProportionPair captionProportionPair = observableMap[currentMemberkey];
      captionProportionPair.proportion = currentMemberHours;

    }
  }
    // Build the date range slider
    var dateRangeSlider = js.context.$("#date_section_range_slider").dateRangeSlider(js.map({

      'wheelMode': "zoom",
      'bounds':
        js.map( {
          'min': minDate,
          'max': maxDate}
        ) ,

        'defaultValues':
          js.map( {
            'min': minDate,
            'max': maxDate}
          )
    }));

    // define the method called when data in the slider is changing
    void dateSliderValuesChanging (e, data){

      DateTime firstDate = data.values.min;
      DateTime lastDate = data.values.max;

      calculateChartData(firstDate, lastDate);
    }
    js.context.$("#date_section_range_slider")
      .bind("valuesChanging", dateSliderValuesChanging);


    // calculate the data the first time.
    calculateChartData(minDate, maxDate);
}





