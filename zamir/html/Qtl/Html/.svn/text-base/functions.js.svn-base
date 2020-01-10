

function il_in_experiment(ex)
{
 				 var expr = ex;
				 var arr = new Array();
				 if (expr.search("Akko_-_1993_-_Wet") != -1)
				 {
				 		arr[0] = "IL1-1-2";
						arr[1] = "IL1-1-3";
						arr[2] = "IL1-4-18";
						arr[3] = "IL10-1-1";
						arr[4] = "IL10-2-2";
						arr[5] = "IL11-4-1";
						arr[6] = "IL12-1-1";
						arr[7] = "IL12-3-1";
						arr[8] = "IL12-4-1";
						arr[9] = "IL2-1-1";
						arr[10] = "IL2-6-5";
						arr[11] = "IL4-1-1";
						arr[12] = "IL4-3-2";
						arr[13] = "IL6-2-2";
						arr[14] = "IL7-4-1";
						arr[15] = "IL7-5-5";
						arr[16] = "IL8-1-1";
						arr[17] = "IL8-1-3";
						arr[18] = "IL8-2-1";
						arr[19] = "IL8-3-1";
						arr[20] = "IL9-1-2";
						arr[21] = "IL9-1-3";
						arr[22] = "IL9-2-5";
						arr[23] = "IL9-2-6";
						arr[24] = "IL9-3-1";
						arr[25] = "IL9-3-2";			
						
						return arr;			
				 }
				 if (expr.search("Akko_-_2000_-_Dry") != -1)
				 {
				 		arr[0] = "IL7-5-5";
				 		arr[1] = "IL9-3-1";
						
						return arr;
				 }
				 if (expr.search("Akko_-_2000_-_Wet") != -1)
				 {
				 		arr[0] = "IL7-5-5";
				 		arr[1] = "IL9-3-1";
						
						return arr;
				 }
				 if (expr.search("France_-_2000_-_plots_-_Wet") != -1)
				 {
				 		arr[0] = "IL1-1";
				 		arr[1] = "IL1-1-3";
						arr[2] = "IL3-3";
						arr[3] = "IL6-2";
						arr[4] = "IL6-2-2";
						arr[5] = "IL6-3";
						arr[6] = "IL7-5-5"
						arr[7] = "IL9-3-1";
						
						return arr;
				 }
				 if (expr.search("Akko_-_2001_-_Wet") != -1)
				 {
				 		arr[0] = "IL3-1";
				 							
						return arr;
				 }
				 if (expr.search("Akko_-_2002_-_Wet") != -1)
				 {
				 		arr[0] = "IL1-1";
				 								
						return arr;
				 }
				 
				 return arr;
}


function check_il(ex, i)
{
 			var arr = il_in_experiment(ex);
			var il = i;
 		 
		  return !(isExist(arr, il));

}

function isExist(arr, i)
{
 var array = arr;
 var il = i;
 var j;
 
 
 for (j=0; j<array.length; j++)
 {
 		 if (il.search(array[j]) != -1  && array[j].search(il) != -1)
		 		return true;
 }
 return false;
 

}


function del_ex(arr, ex)
{
	var old_array = arr;
	var exp   = ex;
	var new_array = new Array();
	var i;	
	var c;
	
	c=0;
	
	for (i=0; i<old_array.length; i++)
	{
		if (old_array[i].search(exp) == -1)
		{
			new_array[c] = old_array[i];
			c++;
		
		}
	
	}
	
	return new_array;
}


function get_ex_by_tr(tr, t)	//1 - specific ex for a trait, 2-combind/selected ex, 3 - all ex
{
	var type = t;
	var trait = tr;
	var ar = all_experiments();
	
	if (type == 3)
		return ar;
	
	if (tr.search("Plant_Weight") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2]);	
		return ar[2];
	}
	if (tr.search("Total_Yield") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2]);
		return ar[2];	
	}
	if (tr.search("Bio_-_Mass") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2]);
		return ar[2];	
	}
	if (tr.search("Brix_") != -1  &&  tr.search("Yield") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2]);
		return ar[2];	
	}
	if (tr.search("%_Red_Yield") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2]);
		return ar[2];	
	}
	if (tr.search("Harvest_Index") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2]);		
		return ar[2];	
	}
	if (tr.search("Brix") != -1  &&  tr.search("Yield") == -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2], ar[3], ar[4], ar[5]);	
		return 	ar[6];
	}
	if (tr.search("Fruit_Weight") != -1)
	{
		if (type == 1)
			return new Array(ar[0], ar[1], ar[2], ar[3], ar[4], ar[5]);	
		return ar[6];	
	}
	if (tr.search("Fruit_Length") != -1)
	{
		if (type == 1)
			return new Array(ar[4], ar[5]);	
		return ar[5];	
	}
	if (tr.search("Fruit_Width") != -1)
	{
		if (type == 1)
			return new Array(ar[4], ar[5]);	
		return ar[5];	
	}
	if (tr.search("Length_/_Width") != -1)
	{
		if (type == 1)
			return new Array(ar[4], ar[5]);	
		return ar[5];	
	}
	if (tr.search("Pericarp") != -1)
	{
		if (type == 1)
			return new Array(ar[4], ar[5]);	
		return ar[5];		
	}
	if (tr.search("Seed_Weight") != -1)
	{
		if (type == 1)
			return new Array(ar[4]);	
		return ar[4];	
	}
	
	if (tr.search("Internal_Color") != -1)
	{
		if (type == 1)
			return new Array(ar[1], ar[2]);	
		return ar[2];	
	}
	if (tr.search("External_Color") != -1)
	{
		if (type == 1)
			return new Array(ar[1], ar[2]);				
		return ar[2];	
	}
	if (tr.search("A_") != -1)
	{
		if (type == 1)
			return new Array(ar[3]);	
		return ar[3];	
	}
	if (tr.search("B_") != -1)
	{
		if (type == 1)
			return new Array(ar[3]);	
		return ar[3];	
	}
	if (tr.search("L_") != -1)
	{
		if (type == 1)
			return new Array(ar[3]);	
		return ar[3];		
	}
	if (tr.search("Lycopene") != -1)
	{
		if (type == 1)
			return new Array(ar[3]);	
		return ar[3];		
	}
	if (tr.search("Carotene") != -1)
	{
		if (type == 1)
			return new Array(ar[3]);	
		return ar[3];		
	}
	return null;
	
		
}


function all_experiments()
{
	var res = new Array();
	
	res[0]  = "Akko_-_1993_-_Wet";
	res[1]  = "Akko_-_2000_-_Dry";
	res[2]  = "Akko_-_2000_-_Wet";
	res[3]  = "France_-_2000_-_plots_-_Wet";
	res[4]  = "Akko_-_2001_-_Wet";
	res[5]  = "Akko_-_2002_-_Wet";
	res[6]  = "Combined";
	res[7]  = "Global";

	return res;

}

function all_traits()
{
	var res = new Array();
	
	res[0]  = "Plant_Weight";
	res[1]  = "Total_Yield";
	res[2]  = "Bio_-_Mass";
	res[3]  = "Brix_*_Yield";
	res[4]  = "%_Red_Yield";
	res[5]  = "Harvest_Index";
	res[6]  = "Brix";
	res[7]  = "Fruit_Weight";
	res[8]  = "Fruit_Length";
	res[9]  = "Fruit_Width";
	res[10]  = "Length_/_Width";
	res[11]  = "Seed_Weight";
	res[12]  = "Internal_Color";
	res[13]  = "External_Color";
	res[14]  = "A_*";
	res[15]  = "B_*";
	res[16]  = "L_*";
	res[17]  = "Lycopene";
	res[18]  = "Carotene";
	res[19]  = "Pericarp";


	return res;


}



function get_param(s, t)
{
	var st   = s;
	var type = t;
	var kind;
	
	if (type == 4)
	{
		array =  /page_type=(\d)&tr=([\w|\/|%|\-|\*]+)&ex=(.+)&ch=(\d+)&il=(.+)/g.exec(st);

		if (array)
		{
			kind        = array[1];
			tr          = array[2];
			ex          = array[3];
			ch		 	= array[4];
			il          = array[5];
					
			return new Array(kind, tr, ex, ch, il);

		
		}
	}
	if (type == 3)
	{
		array =  /page_type=(\d)&tr=([\w|\/|%|\-|\*]+)&ex=(.+)&ch=(\d+)/g.exec(st);

		if (array)
		{
			kind        = array[1]
			tr          = array[2];
			ex          = array[3];
			ch		 	= array[4];
		
			
		
			return new Array(kind, tr, ex, ch);

		
		}
	
	}
	if (type == 2)
	{
		array =  /page_type=(\d)&tr=([\w|\/|%|\-|\*]+)&ex=(.+)/g.exec(st);

		if (array)
		{
			kind        = array[1];
			tr          = array[2];
			ex          = array[3];
		
			
		
			return new Array(kind, tr, ex);
			//return tr + "" + ex + "" + ch + "" + il;

		}		
	}
	
	array =  /page_type=(\d)&ex=(.+)/g.exec(st);

	if (array)
	{
		kind        = array[1]
		ex          = array[2];
	
		
	
		return new Array(kind, ex);
		//return tr + "" + ex + "" + ch + "" + il;

	}		
	
		
}//end of get_param()




function get_color()
{
	return "#cccccc";
	
}


function get_path(arr, length)
{
	var path_arr = arr;
	var path = "../Pictures/";
	
	for (i=0; i<length; i++)
	{
		if (i < length - 2)
		{		
			path += path_arr[i] + "/";
		}
		else
		{
			path += path_arr[i];
		}
				
	}
	
	return path;


}//end of get_path()



function f_translate_ex(experiment)
{
	var exp = experiment;
	
	if (exp.search("1993") != -1)
	{
		return "1993";
	}
	if (exp.search("Wet") != -1  &&  exp.search("2000") != -1  &&  exp.search("France") == -1)
	{
		return "2000-wet";
	}
	if (exp.search("Dry") != -1  &&  exp.search("2000") != -1)
	{
		return "2000-dry";
	}
	if (exp.search("Combined") != -1)
		return "combined";
	if (exp.search("Global") != -1)
		return "global";	
	if (exp.search("France") != -1)
		return "france-2000";
	if (exp.search("2001") != -1)
		return "2001-wet";	
	if (exp.search("2002") != -1)
		return "2002-wet";	
	
	
	
}//end of translate_ex()


function f_translate_tr(trait)
{
	var exp = trait;
	
	if (exp.search("Plant") != -1   &&   exp.search("Weight") != -1)
	{
		return "PW";
	}
	if (exp.search("Total") != -1   &&  exp.search("Yield") != -1)
	{
		return "TY";
	}
	if (exp.search("Bio") != -1   &&   exp.search("Mass") != -1)
	{
		return "BM";
	}

	if (exp.search("Red") != -1   &&   exp.search("Yield") != -1)
	{
		return "RED";
	}
	
	if (exp.search("Harvest") != -1   &&   exp.search("Index") != -1)
	{
		return "HI";
	}
	
	if (exp.search("Brix") != -1  &&   exp.search("Yield") != -1)   // Brix * Yield
	{
		return "BXY";
	}
	
	if (exp.search("Brix") != -1)
	{
		return "BX";
	}
	
	if (exp.search("Fruit") != -1   &&   exp.search("Weight") != -1)
	{
		return "FW";
	}
	if (exp.search("Fruit") != -1   &&   exp.search("Length") != -1)
	{
		return "LEN";
	}
	if (exp.search("Fruit") != -1   &&   exp.search("Width") != -1)
	{
		return "WID";
	}
	if (exp.search("Length") != -1   &&   exp.search("Width") != -1)	//length/width
	{
		return "LEN_WID";
	}
	if (exp.search("Internal") != -1   &&   exp.search("Color") != -1)
	{
		return "IC";
	}
	if (exp.search("External") != -1   &&   exp.search("Color") != -1)
	{
		return "EC";
	}
	if (exp.search("Pericarp") != -1)
	{
		return "PER";
	}	
	if (exp.search("Seed") != -1   &&   exp.search("Weight") != -1)
	{
		return "SW";
	}
	if (exp.search("A") != -1)
	{
		return "A";
	}
	if (exp.search("B") != -1)
	{
		return "B";
	}
	if (exp.search("L") != -1  &&  exp.search("Lycopene") == -1)
	{
		return "L";
	}
	if (exp.search("Lycopene") != -1)
	{
		return "LYC";
	}
	if (exp.search("Carotene") != -1)
	{
		return "CAR";
	}
	
	
	
	return "my_undefined";
	
	
}//end of translate_tr()





function translate(str)
{
	var st = str
	var spt = st.split("_");
	var res = "";
	var i;
	
	
	for (i=0; i<spt.length; i++)
	{
		res +=  spt[i] + " ";
		
	}
	
	return res;

}
//end of translate

function select_ils()
{
return "<select name='select_ils'> \
		<option value=''>Select IL's	\
		<option value='IL1-1'>IL1-1	\
		<option value='IL1-1-2'>IL1-1-2 \
		<option value='IL1-1-3'>IL1-1-3 \
		<option value='IL1-2'>IL1-2 \
		<option value='IL1-3'>IL1-3 \
		<option value='IL1-4'>IL1-4 \
		<option value='IL1-4-18'>IL1-4-18 \
		\
		<option value='IL2-1'>IL2-1 \
		<option value='IL2-1-1'>IL2-1-1 \
		<option value='IL2-2'>IL2-2 \
		<option value='IL2-3'>IL2-3 \
		<option value='IL2-4'>IL2-4 \
		<option value='IL2-5'>IL2-5 \
		<option value='IL2-6'>IL2-6 \
		<option value='IL2-6-5'>IL2-6-5 \
		\
		<option value='IL3-1'>IL3-1 \
		<option value='IL3-2'>IL3-2  \
		<option value='IL3-3'>IL3-3  \
		<option value='IL3-4'>IL3-4 \
		<option value='IL3-5'>IL3-5 \
		\
		<option value='IL4-1'>IL4-1 \
		<option value='IL4-1-1'>IL4-1-1 \
		<option value='IL4-2'>IL4-2 \
		<option value='IL4-3'>IL4-3 \
		<option value='IL4-3-2'>IL4-3-2 \
		<option value='IL4-4'>IL4-4 \
		\
		<option value='IL5-1'>IL5-1 \
		<option value='IL5-2'>IL5-2 \
		<option value='IL5-3'>IL5-3 \
		<option value='IL5-4'>IL5-4 \
		<option value='IL5-5'>IL5-5 \
		\
		<option value='IL6-1'>IL6-1 \
		<option value='IL6-2'>IL6-2 \
		<option value='IL6-2-2'>IL6-2-2 \
		<option value='IL6-3'>IL6-3 \
		<option value='IL6-4'>IL6-4 \
		\
		<option value='IL7-1'>IL7-1 \
		<option value='IL7-2'>IL7-2 \
		<option value='IL7-3'>IL7-3 \
		<option value='IL7-4'>IL7-4 \
		<option value='IL7-4-1'>IL7-4-1 \
		<option value='IL7-5'>IL7-5 \
		<option value='IL7-5-5'>IL7-5-5 \
		\
		<option value='IL8-1'>IL8-1 \
		<option value='IL8-1-1'>IL8-1-1 \
		<option value='IL8-1-3'>IL8-1-3 \
		<option value='IL8-2'>IL8-2 \
		<option value='IL8-2-1'>IL8-2-1 \
		<option value='IL8-3'>IL8-3 \
		<option value='IL8-3-1'>IL8-3-1 \
		\
		<option value='IL9-1'>IL9-1 \
		<option value='IL9-1-2'>IL9-1-2 \
		<option value='IL9-1-3'>IL9-1-3 \
	  \
		<option value='IL9-2'>IL9-2 \
		<option value='IL9-2-5'>IL9-2-5 \
		<option value='IL9-2-6'>IL9-2-6 \
		<option value='IL9-3'>IL9-3 \
		<option value='IL9-3-1'>IL9-3-1 \
		<option value='IL9-3-2'>IL9-3-2 \
		\
		<option value='IL10-1'>IL10-1 \
		<option value='IL10-1-1'>IL10-1-1 \
		<option value='IL10-2'>IL10-2 \
		<option value='IL10-2-2'>IL10-2-2 \
		<option value='IL10-3'>IL10-3 \
		\
		<option value='IL11-1'>IL11-1 \
		<option value='IL11-2'>IL11-2 \
		<option value='IL11-3'>IL11-3 \
		<option value='IL11-4'>IL11-4 \
		<option value='IL11-4-1'>IL11-4-1 \
		\
		<option value='IL12-1'>IL12-1 \
		<option value='IL12-1-1'>IL12-1-1 \
		<option value='IL12-2'>IL12-2 \
		<option value='IL12-3'>IL12-3 \
		<option value='IL12-3-1'>IL12-3-1 \
		<option value='IL12-4'>IL12-4 \
		<option value='IL12-4-1'>IL12-4-1 \
		</select>";
}
