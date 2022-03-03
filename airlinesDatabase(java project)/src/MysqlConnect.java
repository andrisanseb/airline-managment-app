import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
import java.util.*;
import java.util.Date;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.Random; 


public class MysqlConnect{
public static void main(String[] args) throws SQLException, ParseException {
	Random rand = new Random();
	int randomCounter = rand.nextInt(500); //random number
	System.out.println("Welcome to the Airline Management System");
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/";
	String dbName = "airlines2";
	String driver = "com.mysql.jdbc.Driver";
	String userName = "root"; 
	String password = "";
	
	try{
		Class.forName(driver).newInstance();
		conn = DriverManager.getConnection(url+dbName,userName,password);
		System.out.println("Successfully connected to database");
	}catch(Exception s) {
		s.printStackTrace();
	} 
		Scanner s = new Scanner(System.in);
		Scanner sc = new Scanner(System.in);
		int x ; 
		String y ;

	do{
		System.out.println("Please insert one of the options above:\r\n" +
				"[1] Insert Flight\r\n" + 
				"[2] Insert new/old Customer and Book his Ticket\r\n" + 
				"[3] Show Flights of an Airline\r\n" + 
				"[4] Show Flights that are Full\r\n" + 
				"[5] Update Booking(pay rest ammount or cancel it) \r\n" +
				"[6] Show available flights from Toronto to New York\r\n" + 
				"[7] Show cancelled tickets of an airline and then erase them\r\n" + 
				"[0] Exit\r\n" + 
				"");
		
		x = sc.nextInt();
		if(x==1) {

			boolean notExists=true;
			
			System.out.println("Choose departure airport:");
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM airport");
			
			while(val.next()) {
				String airportCode = val.getString("AIRPORT-CODE");
				String city = val.getString("BOOKING-OFFICE");
				System.out.format("%s , %s\n" ,airportCode,city);
				}
			String depAir;
			do { //elegxos oti to aerodromio pou kataxwrei einai ena apo ta 12 ths ekfwnhshs
				y=s.nextLine();
				depAir=y;
			if("YYZ".equals(depAir) || "CDG".equals(depAir) || "CGN".equals(depAir) || "EDI".equals(depAir) || "FCO".equals(depAir) ||"JFK".equals(depAir) ||"LCY".equals(depAir) || "NAP".equals(depAir) ||"NCE".equals(depAir) || "ORD".equals(depAir) || "TXL".equals(depAir) || "YUL".equals(depAir)) {
				notExists=false;
				}else System.out.println("Please insert one of the airports above");
			}while(notExists);	
			
			st = conn.createStatement();
			val = st.executeQuery("SELECT * FROM airport");
			while(val.next()) {
				String airportCode = val.getString("AIRPORT-CODE");
				if(airportCode.contentEquals(depAir) ==false) {  
					String city = val.getString("BOOKING-OFFICE");
					System.out.format("%s , %s\n" ,airportCode,city);
				}
				}
			
			String arrAir;
			notExists = true;
			do { //elegxos oti to aerodromio pou kataxwrei einai ena apo ta 12 ths ekfwnhshs ektos kai tou aerodromiou anaxwrhshs
				y=s.nextLine();
				arrAir = y;
			if(("YYZ".equals(arrAir) || "CDG".equals(arrAir) || "CGN".equals(arrAir) || "EDI".equals(arrAir) || "FCO".equals(arrAir) ||"JFK".equals(arrAir) ||"LCY".equals(arrAir) || "NAP".equals(arrAir) ||"NCE".equals(arrAir) || "ORD".equals(arrAir) || "TXL".equals(arrAir) || "YUL".equals(arrAir)) && arrAir.contentEquals(depAir)==false) {
				notExists=false;
				}else System.out.println("Please insert one of the airports above");
			}while(notExists);
			
			System.out.println("Choose one of the available airlines:");
		   	st = conn.createStatement();
			val = st.executeQuery("SELECT * FROM airport");
			String[] airlines= {" ", " "};//pinakas gia elegxo airline
			int arr=0;
			while(val.next()) {
				String airportCode = val.getString("AIRPORT-CODE");
				String airportCountry = val.getString("country_countryname");
				ResultSet val1 ;
				if(airportCode.contentEquals(depAir) ==true ||airportCode.contentEquals(arrAir)) {  
					st = conn.createStatement();
					val1 = st.executeQuery("SELECT * FROM country");
					while(val1.next()) {
						String airline=val1.getString("AIRLINE-ID");
						String cname=val1.getString("countryname");
						if(cname.contentEquals(airportCountry)) {
						System.out.format(airline);
						airlines[arr]= airline;
						arr++;
						System.out.println();
						}
					}
				}
			}
			notExists = true;
			String airline;
			do { //elegxos oti to airline einai ena apo ta parapanw airlines (pou eksyphretoun tis sygkekrimenes xwres
				y=s.nextLine();
				airline = y;
			if(airline.equals(airlines[0]) || airline.equals(airlines[1])) {
				notExists=false;
				}else System.out.println("Please insert one of the airlines above");
			}while(notExists);
			
			
			//dep date
			System.out.println("Please Insert the departure date (note:date format dd/MM/yyyy):");
			
			y = s.nextLine();
			String depD= y;
			
			//dep time
			System.out.println("Please Insert the departure time of the flight (time format HH:mm):");
			
			y = s.nextLine();
			String depT =y;
			
			//arr date
			System.out.println("Please Insert the arrival date of the flight (note:date format dd/MM/yyyy):");
			
			y = s.nextLine();
			String arrD = y;
			
			//arr time
			System.out.println("Please Insert the arrival time of the flight (time format HH:mm):");
			
			y = s.nextLine();
			String arrT =y;
			
				Date depDate=new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(depD+" "+depT);
				Date arrDate=new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(arrD+" "+arrT);
				Timestamp depTS = new Timestamp(depDate.getTime());
				Timestamp arrTS = new Timestamp(arrDate.getTime());

				long diffInMillies = Math.abs(arrDate.getTime() - depDate.getTime());
			    long diff = TimeUnit.MINUTES.convert(diffInMillies, TimeUnit.MILLISECONDS);
			    long hours = diff / 60; 
			    long minutes = diff % 60;
			    String dur = (hours+" hours and "+minutes);
			    
			    System.out.println("\nInsert the standard flight price:");
			    x=sc.nextInt();
			    int fprice = x ;
			    
			    //flight-id
			    randomCounter++;
			    String id = depAir.substring(0,1) +arrAir.substring(0,1) + String.valueOf(randomCounter);			    
			    
			    //creation of business and economy seats
			    System.out.println("How many economy seats does the flight have?");
			    x=sc.nextInt();
			    int ecoS = x ;
			    System.out.println("How many business seats does the plane have (If the flight doesnt have then type 0)?");
			    x=sc.nextInt();
			    int busS = x ;
			    
			    System.out.println("How many smoking seats does the plane have (If the flight doesnt have then type 0)?");
			    x=sc.nextInt();
			    int smokS = x ;
			    
			    try{ 
			    	st = conn.createStatement();
				
				int val2 = st.executeUpdate("INSERT INTO flight VALUES('"+id+"','"+depTS+"','"+arrTS+"','"+dur+"',"+fprice+",'"+depAir+"','"+arrAir+"','"+airline+"')");
				
				System.out.println("Flight successfully inserted!");
				}catch(SQLException k){
					System.out.println("SQL statement is not executed!");
				}
			    
				try {
				st = conn.createStatement();
				int val3=st.executeUpdate("INSERT INTO trclass VALUES('eco',"+ecoS+",0,'"+id+"')");
				
					System.out.println("Economy Seats successfully inserted!");
				}catch(SQLException k){
					System.out.println("SQL statement is not executed!");
				} 
				try {	
					st = conn.createStatement();
					int val4=st.executeUpdate("INSERT INTO trclass VALUES('buss',"+busS+",0,'"+id+"')");
					
					System.out.println("Bussiness Class successfully inserted!");
				}catch(SQLException k){
					System.out.println("SQL statement is not executed!");
				} 
				
				
				for(int i=1;i<=ecoS;i++){
					String seatPK= String.valueOf(i) + String.valueOf(id);
					if(i<=smokS){
						int val2=st.executeUpdate("INSERT INTO seat VALUES('','yes','eco','"+id+"',NULL,'"+seatPK+"',"+i+")");
					}else{
						int val2=st.executeUpdate("INSERT INTO seat VALUES('','no','eco','"+id+"',NULL,'"+seatPK+"',"+i+")");
					}

				}
				for(int i=(ecoS+1);i<=busS+ecoS;i++){
					String seatPK= String.valueOf(i) + String.valueOf(id);
					int val2=st.executeUpdate("INSERT INTO seat VALUES('','no','buss','"+id+"',NULL,'"+seatPK+"',"+i+")");
					}
				
				int val5= st.executeUpdate("INSERT INTO airportmanagement VALUES('"+depAir+"','"+id+"')");
				int val6= st.executeUpdate("INSERT INTO airportmanagement VALUES('"+arrAir+"','"+id+"')");
			
		}else if(x==2) {
			System.out.println("Insert the Customer's Document ID:\n");			
			boolean exists = false;
			String customerid;
			s = new Scanner(System.in);
			y=s.nextLine();
			customerid = y;
			int bookids=0;
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM customer");
			st = conn.createStatement();
			val = st.executeQuery("SELECT * FROM customer");
			while(val.next()) {
					String customeridb = val.getString("documentid");
					ResultSet val1 ;
					if(customerid.equals(customeridb)) {
						//takes name and converts it to integer(used in bookid)-always random
						int fn=val.getString("name").length();
						String fns = String.valueOf(fn);
						int ln=val.getString("surname").length();
						String lns = String.valueOf(ln);
						int randomidnum = rand.nextInt(1000);
						randomidnum++;
						String randomidnums = String.valueOf(randomidnum);
						String bookid = fns+lns+randomidnums;
						bookids = Integer.valueOf(bookid);
						
						exists=true;
					}
			}
			if(exists) {
				System.out.println("Customer already exists in the database!");
				System.out.println("Choose departure airport:");
				 st = conn.createStatement();
				 val = st.executeQuery("SELECT * FROM airport");
				
				while(val.next()) {
					String airportCode = val.getString("AIRPORT-CODE");
					String city = val.getString("BOOKING-OFFICE");
					System.out.format("%s , %s\n" ,city,airportCode);
					}
				y = s.nextLine();
				String depAir=y;
				
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM airport");
				System.out.println("Choose arrival  airport:");
				while(val.next()) {
					String airportCode = val.getString("AIRPORT-CODE");
					if(airportCode.contentEquals(depAir) ==false) {  
						String city = val.getString("BOOKING-OFFICE");
						System.out.format("%s , %s\n" ,city,airportCode);
					}
					}
				
				String arrAir;
				boolean notExists = true;
				do { //elegxos oti to aerodromio pou kataxwrei einai ena apo ta 12 ths ekfwnhshs ektos kai tou aerodromiou anaxwrhshs
					y=s.nextLine();
					arrAir = y;
				if(("YYZ".equals(arrAir) || "CDG".equals(arrAir) || "CGN".equals(arrAir) || "EDI".equals(arrAir) || "FCO".equals(arrAir) ||"JFK".equals(arrAir) ||"LCY".equals(arrAir) || "NAP".equals(arrAir) ||"NCE".equals(arrAir) || "ORD".equals(arrAir) || "TXL".equals(arrAir) || "YUL".equals(arrAir)) && arrAir.contentEquals(depAir)==false) {
					notExists=false;
					}else System.out.println("Please insert one of the airports above:");
				}while(notExists);
				float price = 0;
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM flight");
				int counter=0;
				String flclid="";
				int smokleft=0;
				int remeco=0;
				int rembus=0;
				while(val.next()) {
					String from = val.getString("FROM");
					String to = val.getString("TO");
					if(from.contentEquals(depAir) && to.contentEquals(arrAir)) {
						counter++;
					DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
					String airline = val.getString("airline");
					Date depDate = val.getTimestamp("DEPARTURE-DATETIME");
					Date arrDate = val.getTimestamp("ARRIVAL-DATETIME");
					price = val.getInt("FLIGHT-PRICE");
					String flightid=val.getString("FLIGHTID");
					st = conn.createStatement();
					ResultSet val1 = st.executeQuery("SELECT * FROM trclass");
					while(val1.next()) {
						flclid = val1.getString("FLIGHT_FLIGHTID");
						if(flclid.contentEquals(flightid)) {
							String classid = val1.getString("classid");
							int total = val1.getInt("total");
							int booked = val1.getInt("booked");
							int rem = total-booked;
							if(classid.contentEquals("eco")) {
								 remeco=rem;
							}else {
								 rembus=rem;
							}
						}
					}
					st = conn.createStatement();
					ResultSet val2 = st.executeQuery("SELECT * FROM seat WHERE issmoking = 'yes' ;");
					while(val2.next()) {
						String flseatid = val2.getString("TRAVEL-CLASS_FLIGHT_FLIGHT-ID");
						
						if(flseatid.contentEquals(flightid)) {
							String seatstate = val2.getString("SEAT_STATE");
							String smoking = val2.getString("issmoking");
							if(seatstate.contentEquals("") ||seatstate.contentEquals("b")) {
								smokleft++;
							}
						}
					}
					if(counter!=0) {
					System.out.format("[%d]  %s performs this flight on %s  ,arrives on %s \n Seats left: %d economy  %d bussiness %d smoking \n\n",counter,airline,dateFormat.format(depDate).toString(),dateFormat.format(arrDate).toString(),remeco,rembus,smokleft);
					}
					}
				}
				
				if(counter!=0) {
				System.out.println("Type the number of the flight you want:");
				x=sc.nextInt();
				int cnumber =x;
				
				System.out.println("Type seat class(smoking seats are economy class only)\n eco  buss  smoking (NOTE: buss class costs 1,5*standard price)");
				y=s.nextLine();
				String clid=y;
				int seatidd=0;
				String q="AIRPORT-CODE";
				double totalcost=price;
				st = conn.createStatement();
				ResultSet val2 = st.executeQuery("SELECT * FROM airport");
				while(val2.next()) {
					String airid=val2.getString("AIRPORT-CODE");
					if(airid.contentEquals(arrAir)||airid.contentEquals(depAir)) {
					double tax = val2.getDouble("AIRPORT-TAX");
					totalcost=totalcost+tax;
					}
				}
				
				
				
				if(clid.contentEquals("buss")) {
					totalcost=totalcost*(1.5);
				System.out.format("This ticket costs %.2f\n",(totalcost));
				
				}else {
					System.out.format("This ticket costs %.2f\n",totalcost);
				}
				System.out.println("How much would you want to pay in advance?(whole cost if you want)\n");
	
				Double xx=sc.nextDouble();
				double paid=xx;
				
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM flight");
				counter=1;
				String HEREflightid="";
				while(val.next()) {
					String from = val.getString("FROM");
					String to = val.getString("TO");
					if(from.contentEquals(depAir) && to.contentEquals(arrAir) ) {
						if(cnumber==counter) {
						
						HEREflightid=val.getString("FLIGHTID");
						break;
						}else { counter++; }
					}
				}
				
				q="SEATID";
				String qcid = "";
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM seat ORDER BY seatnum");
				while(val.next()) {
					int seatnum=val.getInt("seatnum");
					String flid = val.getString("TRAVEL-CLASS_FLIGHT_FLIGHT-ID");
					String seatstate = val.getString("SEAT_STATE");
					qcid = val.getString("TRAVEL-CLASS_CLASSID");
					String smoking = val.getString("issmoking");
					String bookid=val.getString("booking_bookid");
				
					if( bookid==null &&flid.contentEquals(HEREflightid)) {
					
						if(clid.contentEquals("smoking") && smoking.contentEquals("yes") && qcid.contentEquals("eco")) {
							seatidd=seatnum;
							break;
						}else if(clid.contentEquals("eco")&& smoking.contentEquals("no")&& qcid.contentEquals("eco")) {
							seatidd=seatnum;
							break;
						}else if(clid.contentEquals("buss")&& smoking.contentEquals("no")&& qcid.contentEquals("buss")) {
							seatidd=seatnum;
							break;
						}
					}
			}
				
				//aythn thn xronikh stigmh
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
				LocalDateTime bookdatenow = LocalDateTime.now();  
				//System.out.println(dtf.format(bookdatenow));
				
				
				//enhmerwsh database 
				System.out.format("\n Booking code: %s ",bookids);
				System.out.format("\n Seat booked: %s ",seatidd);
				String seatPK= String.valueOf(seatidd) + String.valueOf(HEREflightid);
				
				st = conn.createStatement();
				int val5 = st.executeUpdate("INSERT INTO booking VALUES("+bookids+", '"+bookdatenow+"','"+customerid+"','"+HEREflightid+"',"+seatidd+","+totalcost+","+paid+")");
				
				if(paid==totalcost) {
				int val7 = st.executeUpdate("UPDATE seat SET booking_bookid = "+bookids+" , SEAT_STATE = 'a' WHERE seat_flPK= '"+seatPK+"';");
				System.out.println("Seat Reserved-Full amount paid");
				}else {
					int val7 = st.executeUpdate("UPDATE seat SET booking_bookid = "+bookids+" , SEAT_STATE = 'b' WHERE seat_flPK= '"+seatPK+"';");
					System.out.println();
					System.out.format("Seat Reserved-Need to pay  %.2f ",(totalcost-paid));
				} 

					int val8 =st.executeUpdate("UPDATE trclass SET booked = booked +1 WHERE classid = '"+qcid+"' AND FLIGHT_FLIGHTID = '"+HEREflightid+"'");
					System.out.println("Booking added to database!");
			}														
				
			}else {
				System.out.println("New customer");	
				//new customer creation
				
				System.out.println("Insert First Name");
				y=s.nextLine();
				String fname=y;
				
				System.out.println("Insert Last Name");
				y=s.nextLine();
				String lname=y;
				
				System.out.println("Insert as many Telephone numbers as you want(leave blank and press enter if you dont want to insert any number):");
				y=s.nextLine();
				String tel = y;
				
				System.out.println("Insert as many email addresses as you want(leave blank and press enter if you dont want to insert any email):");
				y=s.nextLine();
				String email=y;
				//elegxos gia email
				
				System.out.println("Insert as many Fax numbers as you want(leave blank and press enter if you dont want to insert any email):");
				y=s.nextLine();
				String fax = y;
				
				System.out.println("Insert country:");
				y=s.nextLine();
				String country=y;
				
				//check if country exists in db
				exists=false;
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM country");
				while(val.next()) {
						String countrynamedb = val.getString("countryname");
						ResultSet val1 ;
						if(country.equals(countrynamedb) ==true) {
							//System.out.println("Country already exists in the database!");	
							exists=true;
						}
				}
				if(exists==false) {
					System.out.println("Insert telephone-code of this country:(format 00xx)");
					x=sc.nextInt();
					int telcode=x;
					System.out.println("Insert the currency of the country:");
					y=s.nextLine();
					String curr = y;
					st = conn.createStatement();
					int val4 = st.executeUpdate("INSERT INTO country VALUES('"+country+"',"+telcode+",'"+curr+"',NULL)");
				}				
				
				System.out.println("Insert Street Adress:");
				y=s.nextLine();
				String street=y;
				
				System.out.println("Insert Area Code:");
				x=sc.nextInt();
				int areacode=x;
				
				System.out.println("Insert Town:");
				y=s.nextLine();
				String town=y;
				
				System.out.println("Insert State:");
				y=s.nextLine();
				String state=y;
				st = conn.createStatement();
				int val1 = st.executeUpdate("INSERT INTO homeaddress VALUES('"+country+"','"+street+"', "+areacode+", '"+town+"','"+state+"')");
				int val2 = st.executeUpdate("INSERT INTO customer VALUES('"+customerid+"','"+fname+"', '"+lname+"','"+tel+"','"+email+"','"+fax+"','"+street+"',"+areacode+", '"+country+"')");
				
				
				//COPY-PASTE ton anwtero kwdika
				
				System.out.println("Choose departure airport:");
				 st = conn.createStatement();
				 val = st.executeQuery("SELECT * FROM airport");
				
				while(val.next()) {
					String airportCode = val.getString("AIRPORT-CODE");
					String city = val.getString("BOOKING-OFFICE");
					System.out.format("%s , %s\n" ,city,airportCode);
					}
				y = s.nextLine();
				String depAir=y;
				
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM airport");
				System.out.println("Choose arrival  airport:");
				while(val.next()) {
					String airportCode = val.getString("AIRPORT-CODE");
					if(airportCode.contentEquals(depAir) ==false) {  
						String city = val.getString("BOOKING-OFFICE");
						System.out.format("%s , %s\n" ,city,airportCode);
					}
					}
				
				String arrAir;
				boolean notExists = true;
				do { //elegxos oti to aerodromio pou kataxwrei einai ena apo ta 12 ths ekfwnhshs ektos kai tou aerodromiou anaxwrhshs
					y=s.nextLine();
					arrAir = y;
				if(("YYZ".equals(arrAir) || "CDG".equals(arrAir) || "CGN".equals(arrAir) || "EDI".equals(arrAir) || "FCO".equals(arrAir) ||"JFK".equals(arrAir) ||"LCY".equals(arrAir) || "NAP".equals(arrAir) ||"NCE".equals(arrAir) || "ORD".equals(arrAir) || "TXL".equals(arrAir) || "YUL".equals(arrAir)) && arrAir.contentEquals(depAir)==false) {
					notExists=false;
					}else System.out.println("Please insert one of the airports above:");
				}while(notExists);
				float price = 0;
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM flight");
				int counter=0;
				String flclid="";
				int smokleft=0;
				int remeco=0;
				int rembus=0;
				while(val.next()) {
					String from = val.getString("FROM");
					String to = val.getString("TO");
					if(from.contentEquals(depAir) && to.contentEquals(arrAir)) {
						counter++;
					DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
					String airline = val.getString("airline");
					Date depDate = val.getTimestamp("DEPARTURE-DATETIME");
					Date arrDate = val.getTimestamp("ARRIVAL-DATETIME");
					price = val.getInt("FLIGHT-PRICE");
					String flightid=val.getString("FLIGHTID");
					st = conn.createStatement();
					ResultSet val11 = st.executeQuery("SELECT * FROM trclass");
					while(val11.next()) {
						flclid = val11.getString("FLIGHT_FLIGHTID");
						if(flclid.contentEquals(flightid)) {
							String classid = val11.getString("classid");
							int total = val11.getInt("total");
							int booked = val11.getInt("booked");
							int rem = total-booked;
							if(classid.contentEquals("eco")) {
								 remeco=rem;
							}else {
								 rembus=rem;
							}
						}
					}
					st = conn.createStatement();
					ResultSet val22 = st.executeQuery("SELECT * FROM seat WHERE issmoking = 'yes' ;");
					while(val22.next()) {
						String flseatid = val22.getString("TRAVEL-CLASS_FLIGHT_FLIGHT-ID");
						
						if(flseatid.contentEquals(flightid)) {
							String seatstate = val22.getString("SEAT_STATE");
							String smoking = val22.getString("issmoking");
							if(seatstate.contentEquals("") ||seatstate.contentEquals("b")) {
								smokleft++;
							}
						}
					}
					if(counter!=0) {
					System.out.format("[%d]  %s performs this flight on %s  ,arrives on %s \n Seats left: %d economy  %d bussiness %d smoking \n\n",counter,airline,dateFormat.format(depDate).toString(),dateFormat.format(arrDate).toString(),remeco,rembus,smokleft);
					}
					}
				}
				
				if(counter!=0) {
				System.out.println("Type the number of the flight you want:");
				x=sc.nextInt();
				int cnumber =x;
				
				System.out.println("Type seat class(smoking seats are economy class only)\n eco  buss  smoking (NOTE: buss class costs 1,5*standard price)");
				y=s.nextLine();
				String clid=y;
				int seatidd=0;
				String q="AIRPORT-CODE";
				double totalcost=price;
				st = conn.createStatement();
				ResultSet val222 = st.executeQuery("SELECT * FROM airport");
				while(val222.next()) {
					String airid=val222.getString("AIRPORT-CODE");
					if(airid.contentEquals(arrAir)||airid.contentEquals(depAir)) {
					double tax = val222.getDouble("AIRPORT-TAX");
					totalcost=totalcost+tax;
					}
				}
				
				
				if(clid.contentEquals("buss")) {
					totalcost=totalcost*(1.5);
				System.out.format("This ticket costs %.2f\n",(totalcost));
				
				}else {
					System.out.format("This ticket costs %.2f\n",totalcost);
				}
				System.out.println("How much would you want to pay in advance?(whole cost if you want)\n");
				x=sc.nextInt();
				double paid=x;
				
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM flight");
				counter=1;
				String HEREflightid="";
				while(val.next()) {
					String from = val.getString("FROM");
					String to = val.getString("TO");
					if(from.contentEquals(depAir) && to.contentEquals(arrAir) ) {
						if(cnumber==counter) {
						
						HEREflightid=val.getString("FLIGHTID");
						break;
						}else { counter++; }
					}
				}
				
				q="SEATID";
				String qcid = "";
				st = conn.createStatement();
				val = st.executeQuery("SELECT * FROM seat ORDER BY seatnum");
				while(val.next()) {
					int seatnum=val.getInt("seatnum");
					String flid = val.getString("TRAVEL-CLASS_FLIGHT_FLIGHT-ID");
					String seatstate = val.getString("SEAT_STATE");
					qcid = val.getString("TRAVEL-CLASS_CLASSID");
					String smoking = val.getString("issmoking");
					String bookid=val.getString("booking_bookid");
					
					if( bookid==null &&flid.contentEquals(HEREflightid)) {
					
						if(clid.contentEquals("smoking") && smoking.contentEquals("yes") && qcid.contentEquals("eco")) {
							seatidd=seatnum;
							break;
						}else if(clid.contentEquals("eco")&& smoking.contentEquals("no")&& qcid.contentEquals("eco")) {
							seatidd=seatnum;
							break;
						}else if(clid.contentEquals("buss")&& smoking.contentEquals("no")&& qcid.contentEquals("buss")) {
							seatidd=seatnum;
							break;
						}
					}
			}
				
				
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
				LocalDateTime bookdatenow = LocalDateTime.now();  
				
				
				//enhmerwsh database
				
				bookids=rand.nextInt(500)+rand.nextInt(550);
				System.out.format("\n Booking code: %s ",bookids);
				System.out.format("\n Seat booked: %s ",seatidd);
				String seatPK= String.valueOf(seatidd) + String.valueOf(HEREflightid);
				
				st = conn.createStatement();
				int val5 = st.executeUpdate("INSERT INTO booking VALUES("+bookids+", '"+bookdatenow+"','"+customerid+"','"+HEREflightid+"',"+seatidd+","+totalcost+","+paid+")");
				
				if(paid==totalcost) {
				int val7 = st.executeUpdate("UPDATE seat SET booking_bookid = "+bookids+" , SEAT_STATE = 'a' WHERE seat_flPK= '"+seatPK+"';");
				System.out.println("Seat Reserved-Full amount paid");
				}else {
					int val7 = st.executeUpdate("UPDATE seat SET booking_bookid = "+bookids+" , SEAT_STATE = 'b' WHERE seat_flPK= '"+seatPK+"';");
					System.out.println();
					System.out.format("Seat Reserved-Need to pay  %.2f ",(totalcost-paid));
				} 

					int val8 =st.executeUpdate("UPDATE trclass SET booked = booked +1 WHERE classid = '"+qcid+"' AND FLIGHT_FLIGHTID = '"+HEREflightid+"'");
					System.out.println("Booking added to database!");
			}
			}
			
		}else if(x==3) {
		
			System.out.println("Type the name of the Airline you want to view:\r\n" +
					"AirCan\r\n" + 
					"AirFrance\r\n" + 
					"LuftAir\r\n" + 
					"BritAir\r\n" + 
					"USAir\r\n" + 
					"ItalAir\r\n" +  
					"");
			s = new Scanner(System.in);
			y = s.nextLine();
			
			String airline = y ;
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM flight WHERE airline = '" +y+ "'");
			System.out.println("id   Departure Airport   Arrival Airport   Standard Price   Departure Date and Time   Arrival Date and Time");
			while(val.next()) {
				String id = val.getString("FLIGHTID");
				String from = val.getString("FROM");
				String to = val.getString("TO");
				float price = val.getInt("FLIGHT-PRICE");
				//Time duration = val.getTime("FLIGHT-TIME");
			
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
				Date depDate = val.getTimestamp("DEPARTURE-DATETIME");
				Date arrDate = val.getTimestamp("ARRIVAL-DATETIME"); 
				
				long diffInMillies = Math.abs(arrDate.getTime() - depDate.getTime());
			    long diff = TimeUnit.MINUTES.convert(diffInMillies, TimeUnit.MILLISECONDS);
			   
				System.out.format("%s\t\t%s\t\t %s\t\t%.2f\t\t%s\t%s \n \n", id , from,to,price, dateFormat.format(depDate).toString(),dateFormat.format(arrDate).toString());
			} 
		} else if(x==4)  {
			boolean found = false;
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM flight");
			while(val.next()) {
				String id = val.getString("FLIGHTID");
				
				String from = val.getString("FROM");
				String to = val.getString("TO");
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
				Date depDate = val.getTimestamp("DEPARTURE-DATETIME");
				 
				st = conn.createStatement();
				ResultSet val2 = st.executeQuery("SELECT * FROM trclass WHERE FLIGHT_FLIGHTID ='"+id+"'");
				int ok=0;
				while(val2.next()) {
					int total = val2.getInt("total");
					int booked = val2.getInt("booked");
					if(total==booked) {
						ok++;
					}
				}
				if(ok==2) {
					System.out.println();
					System.out.format("Flight %s  from  %s  to  %s  on %s  is FULL (no eco or buss seats left)",id,from,to,dateFormat.format(depDate).toString());
					found=true;
				}
			}
			if(found==false) {
				System.out.println("There is no Flight totally booked!\n");
			}
			
			
			
		} else if(x==6) {
			
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM flight ORDER BY FLIGHTID");
			
			while(val.next()) {
				String id = val.getString("FLIGHTID");
				String from = val.getString("FROM");
				String to = val.getString("TO");
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
				Date depDate = val.getTimestamp("DEPARTURE-DATETIME");
				if((from.contentEquals("YYZ")&&to.contentEquals("JFK")) ||(from.contentEquals("JFK")&&to.contentEquals("YYZ"))) {
					
					System.out.format("Flight: %s  from: %s  to: %s  on: %s \n ",id,from,to,dateFormat.format(depDate).toString());
					
				}
			}			
		}else if(x==5) {
			
			System.out.println("Insert document Id of the customer:\n");
			
			y = s.nextLine();
			String documentid= y;
			
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM booking WHERE customer_documentid = '"+documentid+"'");
			int bookingid=0;
			double totalcost=0;
			while(val.next()) {
				bookingid = val.getInt("bookid");
				totalcost =val.getInt("total_cost");
				double paid =val.getInt("paid_ammount");
				double rest=totalcost-paid;
				if(rest!=0) {
					System.out.println("We found your booking!");
					System.out.format("Book-ID: %d needs %.2f to be paid.\n",bookingid,rest);
					
				}
			}
			System.out.println("Do you want to pay the rest or cancel it? (Type pay or cancel)");
			y = s.nextLine();
			String answer= y;
			
			if(answer.contentEquals("pay")) {
				st = conn.createStatement();
				int val7 = st.executeUpdate("UPDATE seat SET SEAT_STATE = 'a' WHERE booking_bookid= '"+bookingid+"';");
				int val8 =st.executeUpdate("UPDATE booking SET paid_ammount="+totalcost+" WHERE bookid="+bookingid+"");
			}else if(answer.contentEquals("cancel")) {
				
				int val7 = st.executeUpdate("UPDATE seat SET SEAT_STATE = 'c' WHERE booking_bookid= '"+bookingid+"';");
				System.out.println("This booking has been cancelled!");
			}
			
		} else if(x==7)  {
			
			System.out.println("Type the name of the Airline you want to see the cancelled bookings amount:\r\n" +
					"AirCan\r\n" + 
					"AirFrance\r\n" + 
					"LuftAir\r\n" + 
					"BritAir\r\n" + 
					"USAir\r\n" + 
					"ItalAir\r\n" +  
					"");
			
			y = s.nextLine();
			
			String airline = y ;
			Boolean exists=false;
			Statement st = conn.createStatement();
			ResultSet val = st.executeQuery("SELECT * FROM flight WHERE airline = '" +y+ "'");
			while(val.next()) {
				String HEREflightid = val.getString("FLIGHTID");
				st = conn.createStatement();
				ResultSet val2 = st.executeQuery("SELECT * FROM seat WHERE SEAT_STATE='c'");
				while(val2.next()) {
					String sflid=val2.getString("TRAVEL-CLASS_FLIGHT_FLIGHT-ID");
					int bookid=val2.getInt("booking_bookid");
					String trcl = val2.getString("TRAVEL-CLASS_CLASSID");
					if(sflid.contentEquals(HEREflightid)) {
						exists=true;
						System.out.println(bookid+" is a cancelled booking!");
						st = conn.createStatement();
						int val7 = st.executeUpdate("UPDATE seat SET SEAT_STATE = '',booking_bookid= NULL WHERE booking_bookid= "+bookid+";");
						st = conn.createStatement();
						int val8 = st.executeUpdate("DELETE FROM booking WHERE bookid="+bookid+";");
						st = conn.createStatement();
						int val9 = st.executeUpdate("UPDATE trclass SET booked= booked-1 WHERE classid='"+trcl+"' AND FLIGHT_FLIGHTID='"+sflid+"' ;");

						System.out.println("Booking deleted succesfully!");
					}
				}
			}
			
			if(exists==false) {
				System.out.println("This airline has no cancelled bookings!");
			}
		} else if(x==0) { System.exit(0); }
		//elegxos an exei plhrwsei se 10 meres apthn krathsh
		Statement st = conn.createStatement();
		ResultSet val2 = st.executeQuery("SELECT * FROM booking");
		while(val2.next()) {
			int bookid=val2.getInt("bookid");
			String flightid =val2.getString("FLIGHT_FLIGHT-ID");
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			Date bookDate = val2.getTimestamp("BOOKING-DATE");
			st = conn.createStatement();
			ResultSet val3 = st.executeQuery("SELECT * FROM flight WHERE FLIGHTID='"+flightid+"'");
			
			while(val3.next()) {
				String HEREflightid=val3.getString("FLIGHTID");
				Date depDate= val3.getTimestamp("DEPARTURE-DATETIME");
				
				long diffInMillies = Math.abs(depDate.getTime() - bookDate.getTime());
			    long daysleft = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
			    
			    if(daysleft<=10) {
				st = conn.createStatement();
				int val4 = st.executeUpdate("UPDATE seat SET SEAT_STATE='c' WHERE booking_bookid="+bookid+" AND SEAT_STATE= 'b' ;");
				//System.out.println("NOTIFICATION: a booking was cancelled due to not being paid 10 days before departure");
			    } 
			}
		}
	}while(true);
}
}

