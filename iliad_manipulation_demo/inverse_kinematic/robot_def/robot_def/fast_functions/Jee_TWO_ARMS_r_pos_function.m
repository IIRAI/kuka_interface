function Jee_pos = Jee_TWO_ARMS_r_pos_function( q )

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);
q7 = q(7);

Jee_pos = [ [ (1405096615103407*cos(q1)*sin(q2))/40564819207303340847894502572032 + (6369039975098477*sin(q1)*sin(q2))/22517998136852480 + (54798767989032873*cos(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/8112963841460668169578900514406400 - (248392559028840603*cos(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/4503599627370496000 - (54798767989032873*sin(q6)*(cos(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/8112963841460668169578900514406400 + (248392559028840603*sin(q6)*(cos(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/4503599627370496000 - (248392559028840603*sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)))/900719925474099200 + (54798767989032873*sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)))/1622592768292133633915780102881280 + (54798767989032873*cos(q1)*cos(q4)*sin(q2))/1622592768292133633915780102881280 + (248392559028840603*cos(q4)*sin(q1)*sin(q2))/900719925474099200,        (1405096615103407*cos(q2)*sin(q1))/40564819207303340847894502572032 - (6369039975098477*cos(q1)*cos(q2))/22517998136852480 - (99516615155181*sin(q2))/351843720888320 - (3881147991052059*cos(q4)*sin(q2))/14073748835532800 - (3881147991052059*sin(q6)*(cos(q5)*(sin(q2)*sin(q4) + cos(q2)*cos(q3)*cos(q4)) - cos(q2)*sin(q3)*sin(q5)))/70368744177664000 - (248392559028840603*cos(q6)*(cos(q1)*cos(q2)*cos(q4) + cos(q1)*cos(q3)*sin(q2)*sin(q4)))/4503599627370496000 + (54798767989032873*cos(q6)*(cos(q2)*cos(q4)*sin(q1) + cos(q3)*sin(q1)*sin(q2)*sin(q4)))/8112963841460668169578900514406400 - (3881147991052059*cos(q6)*(cos(q4)*sin(q2) - cos(q2)*cos(q3)*sin(q4)))/70368744177664000 - (248392559028840603*sin(q6)*(cos(q5)*(cos(q1)*cos(q2)*sin(q4) - cos(q1)*cos(q3)*cos(q4)*sin(q2)) + cos(q1)*sin(q2)*sin(q3)*sin(q5)))/4503599627370496000 + (54798767989032873*sin(q6)*(cos(q5)*(cos(q2)*sin(q1)*sin(q4) - cos(q3)*cos(q4)*sin(q1)*sin(q2)) + sin(q1)*sin(q2)*sin(q3)*sin(q5)))/8112963841460668169578900514406400 - (248392559028840603*cos(q1)*cos(q2)*cos(q4))/900719925474099200 + (54798767989032873*cos(q2)*cos(q4)*sin(q1))/1622592768292133633915780102881280 + (3881147991052059*cos(q2)*cos(q3)*sin(q4))/14073748835532800 - (248392559028840603*cos(q1)*cos(q3)*sin(q2)*sin(q4))/900719925474099200 + (54798767989032873*cos(q3)*sin(q1)*sin(q2)*sin(q4))/1622592768292133633915780102881280,      (3881147991052059*sin(q6)*(cos(q3)*sin(q2)*sin(q5) + cos(q4)*cos(q5)*sin(q2)*sin(q3)))/70368744177664000 - (248392559028840603*sin(q4)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3)))/900719925474099200 - (54798767989032873*sin(q4)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3)))/1622592768292133633915780102881280 - (54798767989032873*sin(q6)*(sin(q5)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*cos(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/8112963841460668169578900514406400 - (248392559028840603*sin(q6)*(sin(q5)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q4)*cos(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/4503599627370496000 - (3881147991052059*sin(q2)*sin(q3)*sin(q4))/14073748835532800 - (248392559028840603*cos(q6)*sin(q4)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3)))/4503599627370496000 - (54798767989032873*cos(q6)*sin(q4)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3)))/8112963841460668169578900514406400 - (3881147991052059*cos(q6)*sin(q2)*sin(q3)*sin(q4))/70368744177664000,       (3881147991052059*cos(q5)*sin(q6)*(cos(q2)*cos(q4) + cos(q3)*sin(q2)*sin(q4)))/70368744177664000 - (248392559028840603*cos(q6)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)))/4503599627370496000 - (54798767989032873*cos(q6)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)))/8112963841460668169578900514406400 - (54798767989032873*cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)))/1622592768292133633915780102881280 - (248392559028840603*cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)))/900719925474099200 - (3881147991052059*cos(q6)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)))/70368744177664000 - (54798767989032873*sin(q1)*sin(q2)*sin(q4))/1622592768292133633915780102881280 - (248392559028840603*cos(q5)*sin(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/4503599627370496000 - (54798767989032873*cos(q5)*sin(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/8112963841460668169578900514406400 - (3881147991052059*cos(q2)*sin(q4))/14073748835532800 + (3881147991052059*cos(q3)*cos(q4)*sin(q2))/14073748835532800 + (248392559028840603*cos(q1)*sin(q2)*sin(q4))/900719925474099200, - (3881147991052059*sin(q6)*(sin(q5)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)) - cos(q5)*sin(q2)*sin(q3)))/70368744177664000 - (248392559028840603*sin(q6)*(sin(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) - cos(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/4503599627370496000 - (54798767989032873*sin(q6)*(sin(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) - cos(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/8112963841460668169578900514406400,     (248392559028840603*sin(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/4503599627370496000 + (3881147991052059*cos(q6)*(cos(q5)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)) + sin(q2)*sin(q3)*sin(q5)))/70368744177664000 + (54798767989032873*sin(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/8112963841460668169578900514406400 + (248392559028840603*cos(q6)*(cos(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/4503599627370496000 + (54798767989032873*cos(q6)*(cos(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/8112963841460668169578900514406400 - (3881147991052059*sin(q6)*(cos(q2)*cos(q4) + cos(q3)*sin(q2)*sin(q4)))/70368744177664000, 0];...
            [                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    (2*cos(q1)*sin(q2))/5 + (39*cos(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/500 - (39*sin(q6)*(cos(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/500 + (39*sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)))/100 + (39*cos(q1)*cos(q4)*sin(q2))/100,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         (4967757600021511*sin(q2))/101412048018258352119736256430080 + (2*cos(q2)*sin(q1))/5 + (193742546400838929*cos(q4)*sin(q2))/4056481920730334084789450257203200 + (193742546400838929*sin(q6)*(cos(q5)*(sin(q2)*sin(q4) + cos(q2)*cos(q3)*cos(q4)) - cos(q2)*sin(q3)*sin(q5)))/20282409603651670423947251286016000 + (39*cos(q6)*(cos(q2)*cos(q4)*sin(q1) + cos(q3)*sin(q1)*sin(q2)*sin(q4)))/500 + (193742546400838929*cos(q6)*(cos(q4)*sin(q2) - cos(q2)*cos(q3)*sin(q4)))/20282409603651670423947251286016000 + (39*sin(q6)*(cos(q5)*(cos(q2)*sin(q1)*sin(q4) - cos(q3)*cos(q4)*sin(q1)*sin(q2)) + sin(q1)*sin(q2)*sin(q3)*sin(q5)))/500 + (39*cos(q2)*cos(q4)*sin(q1))/100 - (193742546400838929*cos(q2)*cos(q3)*sin(q4))/4056481920730334084789450257203200 + (39*cos(q3)*sin(q1)*sin(q2)*sin(q4))/100,                                                                                                                                                                                                                                                                                                                                                                                                                                                                 (193742546400838929*sin(q2)*sin(q3)*sin(q4))/4056481920730334084789450257203200 - (39*sin(q4)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3)))/100 - (39*sin(q6)*(sin(q5)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*cos(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/500 - (193742546400838929*sin(q6)*(cos(q3)*sin(q2)*sin(q5) + cos(q4)*cos(q5)*sin(q2)*sin(q3)))/20282409603651670423947251286016000 - (39*cos(q6)*sin(q4)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3)))/500 + (193742546400838929*cos(q6)*sin(q2)*sin(q3)*sin(q4))/20282409603651670423947251286016000,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               (193742546400838929*cos(q2)*sin(q4))/4056481920730334084789450257203200 - (39*cos(q6)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)))/500 - (39*cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)))/100 + (193742546400838929*cos(q6)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)))/20282409603651670423947251286016000 - (39*sin(q1)*sin(q2)*sin(q4))/100 - (39*cos(q5)*sin(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/500 - (193742546400838929*cos(q5)*sin(q6)*(cos(q2)*cos(q4) + cos(q3)*sin(q2)*sin(q4)))/20282409603651670423947251286016000 - (193742546400838929*cos(q3)*cos(q4)*sin(q2))/4056481920730334084789450257203200,                                                                                                                                                                                                                                (193742546400838929*sin(q6)*(sin(q5)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)) - cos(q5)*sin(q2)*sin(q3)))/20282409603651670423947251286016000 - (39*sin(q6)*(sin(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) - cos(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/500,                                                                                                                                                                                                                                                                                                                                                                                               (39*sin(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/500 - (193742546400838929*cos(q6)*(cos(q5)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)) + sin(q2)*sin(q3)*sin(q5)))/20282409603651670423947251286016000 + (39*cos(q6)*(cos(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/500 + (193742546400838929*sin(q6)*(cos(q2)*cos(q4) + cos(q3)*sin(q2)*sin(q4)))/20282409603651670423947251286016000, 0];...
            [            (99516615155181*sin(q1)*sin(q2))/351843720888320 - (7025457269524143*cos(q1)*sin(q2))/202824096036516704239472512860160 - (273992833511441577*cos(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/40564819207303340847894502572032000 - (3881147991052059*cos(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/70368744177664000 + (273992833511441577*sin(q6)*(cos(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/40564819207303340847894502572032000 + (3881147991052059*sin(q6)*(cos(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/70368744177664000 - (3881147991052059*sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)))/14073748835532800 - (273992833511441577*sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)))/8112963841460668169578900514406400 - (273992833511441577*cos(q1)*cos(q4)*sin(q2))/8112963841460668169578900514406400 + (3881147991052059*cos(q4)*sin(q1)*sin(q2))/14073748835532800, (6369039975098477*sin(q2))/22517998136852480 - (99516615155181*cos(q1)*cos(q2))/351843720888320 - (7025457269524143*cos(q2)*sin(q1))/202824096036516704239472512860160 + (248392559028840603*cos(q4)*sin(q2))/900719925474099200 + (248392559028840603*sin(q6)*(cos(q5)*(sin(q2)*sin(q4) + cos(q2)*cos(q3)*cos(q4)) - cos(q2)*sin(q3)*sin(q5)))/4503599627370496000 - (3881147991052059*cos(q6)*(cos(q1)*cos(q2)*cos(q4) + cos(q1)*cos(q3)*sin(q2)*sin(q4)))/70368744177664000 - (273992833511441577*cos(q6)*(cos(q2)*cos(q4)*sin(q1) + cos(q3)*sin(q1)*sin(q2)*sin(q4)))/40564819207303340847894502572032000 + (248392559028840603*cos(q6)*(cos(q4)*sin(q2) - cos(q2)*cos(q3)*sin(q4)))/4503599627370496000 - (3881147991052059*sin(q6)*(cos(q5)*(cos(q1)*cos(q2)*sin(q4) - cos(q1)*cos(q3)*cos(q4)*sin(q2)) + cos(q1)*sin(q2)*sin(q3)*sin(q5)))/70368744177664000 - (273992833511441577*sin(q6)*(cos(q5)*(cos(q2)*sin(q1)*sin(q4) - cos(q3)*cos(q4)*sin(q1)*sin(q2)) + sin(q1)*sin(q2)*sin(q3)*sin(q5)))/40564819207303340847894502572032000 - (3881147991052059*cos(q1)*cos(q2)*cos(q4))/14073748835532800 - (273992833511441577*cos(q2)*cos(q4)*sin(q1))/8112963841460668169578900514406400 - (248392559028840603*cos(q2)*cos(q3)*sin(q4))/900719925474099200 - (3881147991052059*cos(q1)*cos(q3)*sin(q2)*sin(q4))/14073748835532800 - (273992833511441577*cos(q3)*sin(q1)*sin(q2)*sin(q4))/8112963841460668169578900514406400, (273992833511441577*sin(q4)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3)))/8112963841460668169578900514406400 - (3881147991052059*sin(q4)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3)))/14073748835532800 - (248392559028840603*sin(q6)*(cos(q3)*sin(q2)*sin(q5) + cos(q4)*cos(q5)*sin(q2)*sin(q3)))/4503599627370496000 + (273992833511441577*sin(q6)*(sin(q5)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*cos(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/40564819207303340847894502572032000 - (3881147991052059*sin(q6)*(sin(q5)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q4)*cos(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/70368744177664000 + (248392559028840603*sin(q2)*sin(q3)*sin(q4))/900719925474099200 - (3881147991052059*cos(q6)*sin(q4)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3)))/70368744177664000 + (273992833511441577*cos(q6)*sin(q4)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3)))/40564819207303340847894502572032000 + (248392559028840603*cos(q6)*sin(q2)*sin(q3)*sin(q4))/4503599627370496000, (248392559028840603*cos(q2)*sin(q4))/900719925474099200 - (3881147991052059*cos(q6)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)))/70368744177664000 + (273992833511441577*cos(q6)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)))/40564819207303340847894502572032000 + (273992833511441577*cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)))/8112963841460668169578900514406400 - (3881147991052059*cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)))/14073748835532800 + (248392559028840603*cos(q6)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)))/4503599627370496000 + (273992833511441577*sin(q1)*sin(q2)*sin(q4))/8112963841460668169578900514406400 - (3881147991052059*cos(q5)*sin(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/70368744177664000 + (273992833511441577*cos(q5)*sin(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/40564819207303340847894502572032000 - (248392559028840603*cos(q5)*sin(q6)*(cos(q2)*cos(q4) + cos(q3)*sin(q2)*sin(q4)))/4503599627370496000 - (248392559028840603*cos(q3)*cos(q4)*sin(q2))/900719925474099200 + (3881147991052059*cos(q1)*sin(q2)*sin(q4))/14073748835532800, (248392559028840603*sin(q6)*(sin(q5)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)) - cos(q5)*sin(q2)*sin(q3)))/4503599627370496000 - (3881147991052059*sin(q6)*(sin(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) - cos(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/70368744177664000 + (273992833511441577*sin(q6)*(sin(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) - cos(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/40564819207303340847894502572032000, (3881147991052059*sin(q6)*(sin(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) + cos(q1)*cos(q4)*sin(q2)))/70368744177664000 - (248392559028840603*cos(q6)*(cos(q5)*(cos(q2)*sin(q4) - cos(q3)*cos(q4)*sin(q2)) + sin(q2)*sin(q3)*sin(q5)))/4503599627370496000 - (273992833511441577*sin(q6)*(sin(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) - cos(q4)*sin(q1)*sin(q2)))/40564819207303340847894502572032000 + (3881147991052059*cos(q6)*(cos(q5)*(cos(q4)*(sin(q1)*sin(q3) - cos(q1)*cos(q2)*cos(q3)) - cos(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q3)*sin(q1) + cos(q1)*cos(q2)*sin(q3))))/70368744177664000 - (273992833511441577*cos(q6)*(cos(q5)*(cos(q4)*(cos(q1)*sin(q3) + cos(q2)*cos(q3)*sin(q1)) + sin(q1)*sin(q2)*sin(q4)) + sin(q5)*(cos(q1)*cos(q3) - cos(q2)*sin(q1)*sin(q3))))/40564819207303340847894502572032000 + (248392559028840603*sin(q6)*(cos(q2)*cos(q4) + cos(q3)*sin(q2)*sin(q4)))/4503599627370496000, 0]];
end

