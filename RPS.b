import "io"

let help() be
{
  out("This implementation of the classic game\n");
  out("Rock, Paper, Scissors is quite simple.\n");
  out("To select either rock, paper, or scissors,\n");
  out("simply type the first letter of\n");
  out("the word. To keep track of your\n");
  out("win/loss record, type 't' before\n");
  out("any round. To turn off the record,\n");
  out("type 'n'.\n");
}

let artInt() be
{
  let nRNum;
  
  nRNum := random(2);
  if(nRNum = 0) then
    resultis 'r';
  if(nRNum = 1) then
    resultis 'p';
  if(nRNum = 2) then
    resultis 's';
}

let game(nWLT_arr, nDoRecord) be
{
  let cCompMove;
  let cUserMove = inch();
  
  out("\nWhat's your move?\n");
  cUserMove := inch();
  if cUserMove = 't' then
  {
    nDoRecord := 1;
    out("\nTracking enabled\n");
    nWLT_arr := game(nWLT_arr, nDoRecord);
    return;
  }
  if cUserMove = 'n' then
  {
    nDoRecord := 0;
    out("\nTracking disabled\n");
    nWLT_arr := game(nWLT_arr, nDoRecord);
    return;
  } 

  cCompMove := artInt();

  //tie
  if(cCompMove = cUserMove) then
  {
    out("Tie - play again? (type 'b')\n");
    if nDoRecord = 1 then
    {
      nWLT_arr ! 2 +:= 1;
      out("\nWins: %d   Losses: %d   Ties: %d\n",nWLT_arr ! 0, nWLT_arr ! 1, nWLT_arr ! 2);
    }
    resultis nWLT_arr;
  }

  //lose
  if((cCompMove = 'r' /\ cUserMove = 's') \/ 
     (cCompMove = 'p' /\ cUserMove = 'r') \/
     (cCompMove = 's' /\ cUserMove = 'p')) then
  {
    out("You lose. Again? (type 'b')\n");
    if(nDoRecord = 1) then
    {  
      nWLT_arr ! 1 +:= 1;
      out("\nWins: %d   Losses: %d   Ties: %d\n",nWLT_arr ! 0, nWLT_arr ! 1, nWLT_arr ! 2);
    }
    resultis nWLT_arr;
  }

  //win
  if((cUserMove = 'r' /\ cCompMove = 's') \/ 
     (cUserMove = 'p' /\ cCompMove = 'r') \/
     (cUserMove = 's' /\ cCompMove = 'p')) then
  {
    out("You win! Again? (type 'b')\n");
    if(nDoRecord = 1) then
    {  
      nWLT_arr ! 0 +:= 1;
      out("\nWins: %d   Losses: %d   Ties: %d\n",nWLT_arr ! 0, nWLT_arr ! 1, nWLT_arr ! 2);
    }
    resultis nWLT_arr;
  }
}

let start() be
{
  let cUserChar = '', nWLT_arr = vec(3), nLoss = 0, nDoRecord = 0;
  random(-1);
  out("Welcome to Rock/Paper/Scissors.\n\nFor help, type 'h'.");
  out("To begin playing, type 'b'. To exit, type 'e'.\n\n");

  nWLT_arr ! 0 := 0;
  nWLT_arr ! 1 := 0;
  nWLT_arr ! 2 := 0;

  while true do
  {
    cUserChar := inch();
    if cUserChar = 'h' then
      {help();}
    if cUserChar = 't' then
    {
      out("\nTracking enabled\n");
      nDoRecord := 1;
    }
    if cUserChar = 'n' then
    {
      out("\nTracking disabled\n");
      nDoRecord := 0;
    }
    if cUserChar = 'b' then
      {nWLT_arr := game(nWLT_arr, nDoRecord);}
    if cUserChar = 'e' then
      {finish;}
  }
}

