FUNCTION SSA_VALUES
  ; Maritime polluted from OPAC
  maritime = [0.8953,0.89683,0.89836,0.89989,0.90142,0.90295,0.90448,0.90601,0.90754,0.90907,0.9106,$
  0.91158,0.91256,0.91354,0.91452,0.9155,0.91636,0.91722,0.91808,0.91894,0.9198,$
  0.92064,0.92148,0.92232,0.92316,0.924,0.92442,0.92484,0.92526,0.92568,0.9261,$
  0.9275,0.92911,0.92978,0.93014,0.930872,0.9315912,0.93298,0.9335,0.93342,0.933356,$
  0.9332,0.933055,0.932965,0.932875,0.932785,0.93256,0.9322,0.931944,0.9318208,0.931696,$
  0.93156,0.93124,0.93092,0.93052,0.93036,0.9302,0.93012,0.930008,0.929832,0.92956,$
  0.92932,0.929104,0.928856,0.928748,0.92864,0.928568,0.928532,0.928478,0.9284204,0.928388,$
  0.92828,0.928136,0.927844,0.927588,0.927204,0.92682,0.926244,0.925636,0.92538,0.9251944,$
  0.9249384,0.925164,0.9254148,0.9256656,0.9259296,0.9261144,0.926352,0.926616,0.9268272,0.9272496,$
  0.928068,0.92996,0.932072,0.934184,0.935592,0.936472,0.936686,0.934802,0.932918,0.93072,$
  0.9277056,0.9245656,0.920044,0.914392,0.90874,0.9056,0.90224,0.89888,0.89552,0.89216,$
  0.8888,0.9046,0.9204,0.921978947368,0.923763636364,0.9274,0.9266,0.9258,0.92492,0.92396,$
  0.923]

  ; Cumulus continental polluted from OPAC
  cumulus_cont_poll = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,$
  1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,$
  1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,$
  1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,$
  1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,$
  1.0,1.0,1.0,0.99999,0.99997,0.99995,0.99994,0.999926,0.999904,0.99987,$
  0.99984,0.999813,0.999784,0.999772,0.99976,0.999752,0.999748,0.999742,0.9997356,0.999732,$
  0.99972,0.999704,0.999212,0.998724,0.997992,0.99726,0.996162,0.995003,0.994515,0.9941612,$
  0.9936732,0.993888,0.9941616,0.9944352,0.9947232,0.9949248,0.995184,0.995472,0.9957024,0.9961632,$
  0.997056,0.99254,0.986948,0.981356,0.977628,0.975298,0.973936,0.974152,0.974368,0.97462,$
  0.9749656,0.9753256,0.975844,0.976492,0.97714,0.9775,0.87792,0.77834,0.67876,0.57918,$
  0.4796,0.498,0.5164,0.651873684211,0.785518181818,0.9027,0.92922,0.95574,0.9682,0.9666,$
  0.965]

  ; Urban from OPAC
  urban = [0.689,0.68956,0.69012,0.69068,0.69124,0.6918,0.69236,0.69292,0.69348,0.69404,0.6946,$
  0.69338,0.69216,0.69094,0.68972,0.6885,0.6872,0.6859,0.6846,0.6833,0.682,$
  0.68066,0.67932,0.67798,0.67664,0.6753,0.67364,0.67198,0.67032,0.66866,0.667,$
  0.66436,0.661324,0.65808,0.65344,0.64802,0.646512,0.6436,0.63976,0.637728,0.6361024,$
  0.63214,0.628735,0.627005,0.625275,0.623545,0.61922,0.6123,0.608236,0.6062802,0.604299,$
  0.60214,0.59706,0.59198,0.585895,0.583885,0.581875,0.58087,0.579463,0.577252,0.573835,$
  0.57082,0.5681065,0.560272,0.555376,0.55048,0.547216,0.545584,0.543136,0.5405248,0.539056,$
  0.53416,0.527632,0.52432,0.52264,0.52012,0.5176,0.51382,0.50983,0.50815,0.506932,$
  0.505252,0.50388,0.502816,0.501752,0.500632,0.499848,0.49884,0.49772,0.496824,0.495032,$
  0.49156,0.48996,0.488712,0.487464,0.486632,0.486112,0.485398,0.482986,0.480574,0.47776,$
  0.4739008,0.4698808,0.464092,0.456856,0.44962,0.4456,0.43518,0.42476,0.41434,0.40392,$
  0.3935,0.43615,0.4788,0.484747368421,0.492363636364,0.515,0.51608,0.51716,0.51634,0.51362,$
  0.5109]
  
  return, {urban: urban, maritime:maritime, cumulus_cont_poll:cumulus_cont_poll}
END