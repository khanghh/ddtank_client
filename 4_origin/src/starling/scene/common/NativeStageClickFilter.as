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
      
      private function onNativeStageClick(evt:MouseEvent) : void
      {
         _nativeStageClickDisplayObj = evt.target as DisplayObject;
      }
      
      public function isTypeOf(arr:Array) : Boolean
      {
         if(_nativeStageClickDisplayObj == null && arr == null)
         {
            return true;
         }
         if(arr)
         {
            var _loc4_:int = 0;
            var _loc3_:* = arr;
            for each(var clazz in arr)
            {
               if(_nativeStageClickDisplayObj is clazz)
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
