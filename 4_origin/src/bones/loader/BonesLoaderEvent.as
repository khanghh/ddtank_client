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
      
      public function BonesLoaderEvent($type:String, data:Object = null)
      {
         _data = data;
         super($type);
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
