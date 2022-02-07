FROM intersystemsdc/irishealth-community:2021.2.0.649.0-zpm

# create /app
USER root
RUN mkdir /app && chown $ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /app

USER ${ISC_PACKAGE_MGRUSER}

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP irissession.sh /
RUN chmod +x /irissession.sh

# copy source code
WORKDIR /app 

# regular Demo HL7 production
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP install /app/install
# copy src code
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP src /app/src
# test files for HL7 production
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP test /test

SHELL ["/irissession.sh"]

RUN \
  zn "USER" \
  # install webterminal
  zpm "install webterminal" \
  # install demo
  do $SYSTEM.OBJ.LoadDir("/app/install/HL7", "ck", ,1) \
  do $SYSTEM.OBJ.LoadDir("/app/install/Loan", "ck", ,1) \
  do $system.OBJ.Load("/app/install/Loan/latest/csp/app/DemoLoanForm.csp", "ck") \
  do $system.OBJ.Load("/app/install/Loan/latest/csp/app/DemoLoanSubmit.csp", "ck") \ 
  # load src code
  do $system.OBJ.LoadDir("/app/src", "ck", ,1) \
  # auto-start production
  do ##class(Ens.Director).SetAutoStart("Demo.HL7.MsgRouter.Production") \ 
  set sc = 1
  
# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
CMD [ "-l", "/usr/irissys/mgr/messages.log" ]