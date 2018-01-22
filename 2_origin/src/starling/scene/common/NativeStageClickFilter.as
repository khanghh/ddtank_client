package starling.scene.common
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import starling.core.Starling;
   
   public class NativeStageClickFilter implements Disposeable
   {
       
      
      private var _nativeStageClickDisplayObj:DisplayObject;
      
      public function NativeStageClickFilter()
      {
         super();
         Starling.current.nativeStage.addEventListener("click",onNativeStageClick);
      }
      
      private function onNativeStageClick(param1:MouseEvent) : void
      {
         _nativeStageClickDisplayObj = param1.target as DisplayObject;
      }
      
      public function isTypeOf(param1:Array) : Boolean
      {
         if(_nativeStageClickDisplayObj == null && param1 == null)
         {
            return true;
         }
         if(param1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = param1;
            for each(var _loc2_ in param1)
            {
               if(_nativeStageClickDisplayObj is _loc2_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get nativeStageClickDisplayObj() : DisplayObject
      {
         return _nativeStageClickDisplayObj;
      }
      
      public function dispose() : void
      {
         Starling.current.nativeStage.removeEventListener("click",onNativeStageClick);
         _nativeStageClickDisplayObj = null;
      }
   }
}
