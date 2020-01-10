/******************************************************************************
* This file defines the tree menu with it's items and submenus.               *
******************************************************************************/

// User-defined tree menu data.

var treeMenu           = new TreeMenu();  // This is the main menu.
var treeMenuName       = "myMenu_1.0";    // Make this unique for each tree menu.
var treeMenuDays       = 7;               // Number of days to keep the cookie.
var treeMenuFrame      = "menuFrame";     // Name of the menu frame.
var treeMenuImgDir     = "graphics/";     // Path to graphics directory.
var treeMenuBackground = "dnaBG.jpg";     // Background image for menu frame.   
var treeMenuBgColor    = "#ffffff";       // Color for menu frame background.   
var treeMenuFgColor    = "#000000";       // Color for menu item text.
var treeMenuHiBg       = "#008080";       // Color for selected item background.
var treeMenuHiFg       = "#ffffff";       // Color for selected item text.
var treeMenuFont       = 
      "MS Sans Serif,Arial,Helvetica";    // Text font face.
var treeMenuFontSize   = 1;               // Text font size.
var treeMenuRoot       = "Site Menu";     // Text for the menu root.
var treeMenuFolders    = 0;               // Sets display of '+' and '-' icons.
var treeMenuAltText    = true;            // Use menu item text for icon image ALT text.

// Define the items for the top-level of the tree menu.

treeMenu.addItem(new TreeMenuItem("Home", "home.html", "mainFrame", "menu_home.gif"));
treeMenu.addItem(new TreeMenuItem("abstract", "abstract.html", "mainFrame","note.gif"));
treeMenu.addItem(new TreeMenuItem("populations"));
treeMenu.addItem(new TreeMenuItem("protocols"));
treeMenu.addItem(new TreeMenuItem("Search the dataBase","/cgi-bin/mutation_site/mutant03_search.cgi","mainFrame","select.gif"));
treeMenu.addItem(new TreeMenuItem("How to search", "help.html", "mainFrame", "menu_link_ref.gif"));
treeMenu.addItem(new TreeMenuItem("Contacts", "contacts.html", "mainFrame", "mytomato.gif"));
treeMenu.addItem(new TreeMenuItem("links", "links.html","mainFrame","menu_link_external.gif"));

// project protocols submenu.

var proj_prot = new TreeMenu();
proj_prot.addItem(new TreeMenuItem("Mutagenesis"));
proj_prot.addItem(new TreeMenuItem("screening","protocols/screen.html" , "mainFrame"));
proj_prot.addItem(new TreeMenuItem("seed collection","protocols/seeds.html" , "mainFrame"));
proj_prot.addItem(new TreeMenuItem("allelism","protocols/allelism.html" ,"mainFrame"));
proj_prot.addItem(new TreeMenuItem("mapping","protocols/mapping.html" ,"mainFrame"));
treeMenu.items[3].makeSubmenu(proj_prot);

// Project populations submenu.

var proj_pop = new TreeMenu();
proj_pop.addItem(new TreeMenuItem("M82 cultivar", "population/m82.html", "mainFrame", "tom.gif"));
proj_pop.addItem(new TreeMenuItem("family design", "population/family.html", "mainFrame"));
proj_pop.addItem(new TreeMenuItem("bulks", "population/bulk.html", "mainFrame"));
treeMenu.items[2].makeSubmenu(proj_pop);



// protocols mutagenesis submenu.

var prot_mut = new TreeMenu();
prot_mut.addItem(new TreeMenuItem("fast-neutron", "protocols/mutagen/fn.html", "mainFrame"));
prot_mut.addItem(new TreeMenuItem("EMS", "protocols/mutagen/ems.html", "mainFrame"));
proj_prot.items[0].makeSubmenu(prot_mut);

