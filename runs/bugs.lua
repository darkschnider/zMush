FILE = {
  {
    announce = 'CS, next Bugs',
  },
  {
    skip = 6,
    path = '10 s;20 w;20 w;20 w;20 w;20 w;20 w;20 w;14 w;3 n;w;4 nw;2 w',
    announce = 'Bugs: 5x Bug 2-3m',
  },
  {
    path = '2 w;2 nw;2 w;nw;2 w;sw',
    target = 'terracarapid',
    --alignment = ANGELIC,
    announce = 'Terracarapid 1.7m',
    out = 'e',
    in_commands = 'w',
  },
  {
    path = '2 w',
    target = 'terracarapid',
    --alignment = ANGELIC,
    announce = '2x Terracarapid 1.7m',
    out = 'e',
    in_commands = 'w',
  },
  {
    path = 'n;2 w',
    target = 'terracarapid',
    --alignment = ANGELIC,
    announce = 'Terracarapid 1.7m',
    out = 'e',
    in_commands = 'w',
  },
  {
    path = 's',
    target = 'terracarapid',
    --alignment = ANGELIC,
    announce = '2x Terracarapid 1.7m',
    out = 'e',
    in_commands = 'w',
  },
  {
    path = '2 w',
    target = 'terracarapid',
    --alignment = ANGELIC,
    announce = 'Terracarapid 1.7m',
    out = 'e',
    in_commands = 'w',
  },
  {
    path = 'sw',
    target = 'terracarapid',
    --alignment = ANGELIC,
    announce = 'Terracarapid 1.7m',
    out = 'e',
    in_commands = 'w',
  },

  {
    path= 'n;2 e;se;e;n;3 e;ne;2 e;se;2 e;2 se;2 e',
    announce= 'Bugs, next CS',
  },
  {
    path= '2 e;4 se;e;3 s;14 e;20 e;20 e;20 e;20 e;20 e;20 e;20 e;10 n',
    announce= 'CS, next Reset',
  },
}
  
return { FILE = FILE }