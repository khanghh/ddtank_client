package starling.utils
{
   public function execute(func:Function, ... args) : void
   {
      var i:int = 0;
      var maxNumArgs:int = 0;
      if(func != null)
      {
         maxNumArgs = func.length;
         for(i = args.length; i < maxNumArgs; )
         {
            args[i] = null;
            i++;
         }
         switch(int(maxNumArgs))
         {
            case 0:
               func();
               break;
            case 1:
               func(args[0]);
               break;
            case 2:
               func(args[0],args[1]);
               break;
            case 3:
               func(args[0],args[1],args[2]);
               break;
            case 4:
               func(args[0],args[1],args[2],args[3]);
               break;
            case 5:
               func(args[0],args[1],args[2],args[3],args[4]);
               break;
            case 6:
               func(args[0],args[1],args[2],args[3],args[4],args[5]);
               break;
            case 7:
               func(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
         }
      }
   }
}
