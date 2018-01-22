package bones.loader
{
   import bones.model.BoneVo;
   import flash.events.Event;
   
   public class BonesLoaderEvent extends Event
   {
      
      public static const COMPLETE:String = "complete";
      
      public static const BONES_STYLE_COMPLETE:String = "bonesstylecompelete";
      
      public static const ERROR:String = "error";
       
      
      private var _data:Object;
      
      public function BonesLoaderEvent(param1:String, param2:Object = null)
      {
         _data = param2;
         super(param1);
      }
      
      public function get vo() : BoneVo
      {
         return _data as BoneVo;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
