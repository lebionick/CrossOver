void setup(){
  int n = 100;
  int a[] = new int[n];
  int b[] = new int[n];
  for(int i = 0; i < n; i++){
    a[i]=i;
    b[i]=i;
  }
  //cycle below is used to cacl stats and tune random
  float totalp = 0;
  int totaln = 60000;
  for(int k = 0; k < totaln; k++){
    //suffle
    for(int i = 0; i < n*10; i++){
      swap(a,floor(random(a.length)),floor(random(a.length)));
      swap(b,floor(random(a.length)),floor(random(a.length)));
    }
    //for(int i = 0; i < n; i++)
    //  print(a[i]);
    //println();
    //for(int i = 0; i < n; i++)
    //  print(b[i]);
    //println();
    int[] frankie = crossOver(a, b);
    //for(int i = 0; i < n; i++)
    //  print(frankie[i]);
    int counta = 0;
    for(int i = 0; i < n; i++){
      if(frankie[i] == a[i])
        counta++;
    }
    float aperc = (float) counta / (float) n;
    totalp+=aperc;
    //println(aperc,totalp);
    //println();
    //println(aperc*100,'%');
    //print(100-aperc*100,'%');
  }
  totalp /= (float)totaln;
  println(totalp * 100,'%');
  print(100 - totalp * 100,'%');
}

void swap(int[] arr, int a, int b){
  int buff = arr[a];
  arr[a]=arr[b];
  arr[b]=buff;
}

int[] crossOver(int[] a, int[] b){
  if(a.length != b.length)
    return null;
   int[] result = new int[a.length];
   //find if we have included number from a or b already in child
   for(int i = 0; i < a.length; i++){    
     boolean hasb = false;
     boolean hasa = false;
     for(int j = 0; j < a.length; j++){
       if(hasa == false)
         if(result[j] == a[i]){
           hasa = true;
        }
        if(hasb == false)
         if(result[j] == b[i]){
           hasb = true;
         }
       if(hasa && hasb)
         break;
     }
     if(hasb){
       //if both options were already picked
       if(hasa){
        //we pick the first different from the first array
        for(int j = 0; j < a.length; j++){
          boolean has = false;
          for(int k = 0; k < a.length; k++)
            if(result[k] == a[j]){
              has = true;
              break;
            }
          if(!has)
            result[i] = a[j];
        }
       }
       else //if it has only b
        result[i] = a[i];
     }
     else
     if(hasa)
       result[i]=b[i];
       else {
         //exact number was revealed empirically
         if(random(1) < 0.60785){
           result[i]=a[i];
         }
         else
           result[i]=b[i];
     }
   }
   return result;
}
//for Coding Train from Russia with love:)