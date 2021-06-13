import 'package:express_dt/src/loggers/loggy.dart';

class Message with ExpressLogs {

   void logDebug(String message) {
     loggy.debug(message);
   }

   void logInfo(String message) {
     loggy.info(message);
   }

   void logWarning(String message){
     loggy.warning(message);
   }

   void logError(String message){
     loggy.error(message);
   }
  }