FILE = {
    {
      announce = 'CS, next Legionnaires/Sentries/Cityguards',
    },
    {
      skip = 6,
      path = '9 w;20 sw;20 w;2 w;2 sw;se;e;se;e;steppes;S;w;nw;e;d;sw;e;sw;e;ne;ne;s;se;se;e;nw;d',
      announce = 'Legionnaire 3-5m',
      target = 'legionnaire',
    },
    {
      path = 'downwest',
      target = 'legionnaire',
      --alignment = ANGELIC,
      announce = 'Legionnaire 3-5m',
      out = 'upeast',
      in_commands = 'downeast',
    },
    {
      path = 's',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 'n',
      in_commands = 's',
    },
    {
      path = 'se;s',
      target = 'legionnaire',
      --alignment = ANGELIC,
      announce = 'Legionnaire 3-5m',
      out = 'n',
      in_commands = 's',
    },
    {
      path = 'sw;s;nw',
      target = 'construct',
      --alignment = ANGELIC,
      announce = 'Construct ??m',
      out = 'se',
      in_commands = 'nw',
    },
    {
      path = 'se;n;ne;se;s;sw;2 n;d;e;e;ne',
      target = 'sharamh',
      --alignment = ANGELIC,
      announce = 'Sharamh **EQ MOB** ??m',
      out = 'sw',
      in_commands = 'ne',
    },
    {
      path = 'w;sw;w;u;2 s;ne;s',
      target = 'legionnaire',
      --alignment = ANGELIC,
      announce = '2x Legionnaire 3-5m',
      out = 'n',
      in_commands = 's',
    },
    {
      target = 'marshal',
      --alignment = ANGELIC,
      announce = 'Marshal **EQ MOB** ??m',
      out = 'n',
      in_commands = 's',
    },
    {
      path = 'n;n;nw;n;u;nw;nw',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 's',
      in_commands = 'n',
    },
    {
      path = 'd;sw;sw;sw',
      target = 'harzug',
      --alignment = ANGELIC,
      announce = 'Harzug **EQ MOB** ??m',
      out = 'ne',
      in_commands = 'sw',
    },
    {
      path = 'ne;se;e',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 'w',
      in_commands = 'e',
    },
    {
      path = 'w;nw;s',
      target = 'nurgath',
      --alignment = ANGELIC,
      announce = 'Nurgath **EQ MOB** ??m',
      out = 'n',
      in_commands = 's',
    },
    {
      path = 'n;ne;ne;u',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 'd',
      in_commands = 'u',
    },
    {
      path = 'se;se;u;ne;ne',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 'sw',
      in_commands = 'ne',
    },
     {
      path = 'sw;u',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 'd',
      in_commands = 'u',
    },
    {
      path = 's',
      target = 'infantry',
      --alignment = ANGELIC,
      announce = 'Infantry 300k',
      out = 'n',
      in_commands = 's',
    },
    {
      path = 'se;u;e',
      target = 'sentry',
      --alignment = ANGELIC,
      announce = '3x Sentry 5m',
      out = 'n',
      in_commands = 's',
    },
    {
      path = 'd',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = '2x Cityguard 2-3m',
      out = 'u',
      in_commands = 'd',
    },
    {
      target = 'legionnaire',
      --alignment = ANGELIC,
      announce = '2x Legionnaire 3-5m',
      out = 'u',
      in_commands = 'd',
    },
    {
      path = 'd',
      target = 'sentry',
      --alignment = ANGELIC,
      announce = 'Sentry 5m',
      out = 'u',
      in_commands = 'd',
    },
    {
      target = 'legionnaire',
      --alignment = ANGELIC,
      announce = 'Legionnaire 3-5m',
      out = 'u',
      in_commands = 'd',
    },
    {
      path = '2 d',
      target = 'sentry',
      --alignment = ANGELIC,
      announce = '2x Sentry 5m',
      out = 'u',
      in_commands = 'd',
    },
    {
      path = '4 u;e;d',
      target = 'cityguard',
      --alignment = ANGELIC,
      announce = 'Cityguard 2-3m',
      out = 'u',
      in_commands = 'd',
    },
    {
      path = 'ne;d',
      target = 'infantry',
      --alignment = ANGELIC,
      announce = '2x Infantry 250k',
      out = 'u',
      in_commands = 'd',
    },

    {
      path= 'nw;w;d;d;nw;w;upwest;u;se;w;nw;nw;n;sw;sw;w;ne;w;ne;u;w;se;e;N;mountains;w;nw;w;nw;2 ne;2 e;20 e;20 ne;9 e',
      announce= 'CS, next Reset',
    },
  }
    
  return { FILE = FILE }