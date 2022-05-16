class braille {
  var hangle = List.generate(49, (index)=>List.generate(6, (i)=>0));
  var eng = List.generate(50, (index)=>List.generate(6, (i)=>0));
  var num = List.generate(10, (index)=>List.generate(6, (index)=>0));
  braille(){
    //한글 초기화
    //초성
    hangle[0][1]=1;//ㄱ
    hangle[1][0]=1;hangle[1][1]=1;//ㄴ
    hangle[2][1]=1;hangle[2][2]=1;//ㄷ
    hangle[3][3]=1;//ㄹ
    hangle[4][0]=1;hangle[4][3]=1;//ㅁ
    hangle[5][1]=1;hangle[5][3]=1;//ㅂ
    hangle[6][5]=1;//ㅅ
    hangle[7][1]=1;hangle[7][5]=1;//ㅈ
    hangle[8][3]=1;hangle[8][5]=1;//ㅊ
    hangle[9][0]=1;hangle[9][1]=1;hangle[9][2]=1;//ㅋ
    hangle[10][0]=1;hangle[10][2]=1;hangle[10][3]=1;//ㅌ
    hangle[11][0]=1;hangle[11][1]=1;hangle[11][3]=1;//ㅍ
    hangle[12][1]=1;hangle[12][2]=1;hangle[12][3]=1;//ㅎ
    //초성 된소리
    hangle[13][5]=1;//된소리
    //종성
    hangle[14][0]=1;//종성 ㄱ
    hangle[15][2]=1;hangle[15][3]=1;//종성 ㄴ
    hangle[16][3]=1;hangle[16][4]=1;//종성 ㄷ
    hangle[17][2]=1;//종성 ㄹ
    hangle[18][2]=1;hangle[18][5]=1;//종성 ㅁ
    hangle[19][0]=1;hangle[19][2]=2;//종성 ㅂ
    hangle[20][4]=1;//종성 ㅅ
    hangle[21][2]=1;hangle[21][3]=1;hangle[21][4]=1;hangle[21][5]=1;//종성 ㅇ
    hangle[22][0]=1;hangle[22][4]=1;//종성 ㅈ
    hangle[23][2]=1;hangle[23][4]=1;//종성 ㅊ
    hangle[24][2]=1;hangle[24][3]=1;hangle[24][4]=1;//종성 ㅋ
    hangle[25][2]=1;hangle[25][4]=1;hangle[25][5]=1;//종성 ㅌ
    hangle[26][2]=1;hangle[26][3]=1;hangle[26][5]=1;//종성 ㅍ
    hangle[27][3]=1;hangle[27][4]=1;hangle[27][5]=1;//종성 ㅎ
    //중성
    hangle[28][0]=1;hangle[28][2]=1;hangle[28][5]=1;//ㅏ
    hangle[29][1]=1;hangle[29][3]=1;hangle[29][4]=1;//ㅑ
    hangle[30][1]=1;hangle[30][2]=1;hangle[30][4]=1;//ㅓ
    hangle[31][0]=1;hangle[31][3]=1;hangle[31][5]=1;//ㅕ
    hangle[32][0]=1;hangle[32][4]=1;hangle[32][5]=1;//ㅗ
    hangle[33][1]=1;hangle[33][4]=1;hangle[33][5]=1;//ㅛ
    hangle[34][0]=1;hangle[34][1]=1;hangle[34][4]=1;//ㅜ
    hangle[35][0]=1;hangle[35][1]=1;hangle[35][5]=1;//ㅠ
    hangle[36][1]=1;hangle[36][2]=1;hangle[36][5]=1;//ㅡ
    hangle[37][0]=1;hangle[37][3]=1;hangle[37][4]=1;//ㅣ
    hangle[38][0]=1;hangle[38][2]=1;hangle[38][3]=1;hangle[38][4]=1;//ㅐ
    hangle[39][0]=1;hangle[39][1]=1;hangle[39][3]=1;hangle[39][4]=1;//ㅔ
    hangle[40][0]=1;hangle[40][1]=1;hangle[40][3]=1;
    hangle[40][4]=1;hangle[40][5]=1;//ㅚ
    hangle[41][0]=1;hangle[41][2]=1;hangle[41][4]=1;hangle[41][5]=1;//ㅘ
    hangle[42][0]=1;hangle[42][1]=1;hangle[42][2]=1;hangle[42][4]=1;//ㅝ
    hangle[43][1]=1;hangle[43][2]=1;hangle[43][3]=1;hangle[43][5]=1;//ㅢ
    hangle[44][1]=1;hangle[44][4]=1;//ㅖ
    hangle[45][0]=1;hangle[45][1]=1;hangle[45][4]=1;//ㅟ
    hangle[46][1]=1;hangle[46][3]=1;hangle[46][4]=1;//ㅒ
    hangle[47][0]=1;hangle[47][2]=1;hangle[47][4]=1;hangle[47][5]=1;//ㅙ
    hangle[48][0]=1;hangle[48][1]=1;hangle[48][2]=1;hangle[48][4]=1;//ㅞ
  }
}
//외교관