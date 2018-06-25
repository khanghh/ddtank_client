package ddt.view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.MovieClip;
   
   public class FaceSource
   {
       
      
      public function FaceSource()
      {
         super();
      }
      
      public static function getFaceById(id:int) : MovieClip
      {
         if(id < 102 && id > 0 && DisplayLoader.Context.applicationDomain.hasDefinition("asset.core.expression.Expresion0" + (id < 10?"0" + String(id):String(id))))
         {
            return ClassUtils.CreatInstance("asset.core.expression.Expresion0" + (id < 10?"0" + String(id):String(id))) as MovieClip;
         }
         return null;
      }
      
      public static function getSFaceById(id:int) : MovieClip
      {
         if(id < 49 && id > 0)
         {
            return ClassUtils.CreatInstance("sFace_0" + (id < 10?"0" + String(id):String(id))) as MovieClip;
         }
         return null;
      }
      
      public static function stringIsFace(str:String) : int
      {
         if(str.length != 3 && str.length != 2 || str.slice(0,1) != "/")
         {
            return -1;
         }
         var n:Number = str.slice(1);
         if(n < 49 && n > 0)
         {
            return n;
         }
         return -1;
      }
   }
}
