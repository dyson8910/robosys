// task1_1.c : gcc -shared -fPIC -o task1_1.so task1_1.c -lm

void qs(int* array,int beginning,int end){
  int len = sizeof(array)/sizeof(array[0]);
  int pivot_idx = (beginning+end)/2;
  int pivot = array[pivot_idx];
  int i = beginning,j = end;
  int tmp;
  while(i<=j){
    while(i < end && array[i] < pivot)i++;
    while(j > beginning && array[j] > pivot)j--;
    if(i>=j)break;
    tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;
    i++;j--;
  }
  if(i>beginning+1)qs(array,0,i-1);
  if(j<end-1)qs(array,j+1,end);
}


void quick_sort(int* array,int len){
  qs(array,0,len-1);
}
