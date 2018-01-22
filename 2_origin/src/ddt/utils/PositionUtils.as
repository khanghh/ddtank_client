package ddt.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import flash.geom.Point;
   
   public class PositionUtils
   {
       
      
      public function PositionUtils()
      {
         super();
      }
      
      public static function setPos(param1:*, param2:*) : *
      {
         var _loc3_:* = null;
         if(param2 != null)
         {
            if(param2 is String)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject(param2);
               param1.x = _loc3_.x;
               param1.y = _loc3_.y;
            }
            else if(param2 is Object)
            {
               param1.x = param2.x;
               param1.y = param2.y;
            }
         }
         return param1;
      }
      
      public static function creatPoint(param1:String) : Point
      {
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject(param1);
         return _loc2_;
      }
      
      public static function adaptNameStyleByType(param1:String, param2:FilterFrameText, param3:GradientText) : void
      {
         var _loc4_:* = param1;
         if("isOld" !== _loc4_)
         {
            if("isVIP" !== _loc4_)
            {
               param2.filterString = "core.playerNameTxt.GF2";
               Helpers.setTextfieldFormat(param2,{
                  "color":0,
                  "bold":false,
                  "font":LanguageMgr.GetTranslation("songti")
               },true);
               param2.visible = true;
               if(param3)
               {
                  param3.visible = false;
               }
            }
            else
            {
               if(param3)
               {
                  param3.visible = true;
               }
               param2.visible = false;
            }
         }
         else
         {
            param2.filterString = "core.playerNameTxt.GF";
            Helpers.setTextfieldFormat(param2,{
               "color":11400447,
               "bold":false,
               "font":LanguageMgr.GetTranslation("songti")
            },true);
            param2.visible = true;
            if(param3)
            {
               param3.visible = false;
            }
         }
      }
      
      public static function adaptNameStyle(param1:BasePlayer, param2:FilterFrameText, param3:GradientText) : void
      {
         if(param1)
         {
            if(param1.isOld)
            {
               param2.filterString = "core.playerNameTxt.GF";
               Helpers.setTextfieldFormat(param2,{
                  "color":11400447,
                  "bold":false,
                  "font":LanguageMgr.GetTranslation("songti")
               },true);
               param2.visible = true;
               if(param3)
               {
                  param3.visible = false;
               }
            }
            else if(param1.IsVIP)
            {
               if(param3)
               {
                  param3.visible = true;
               }
               param2.visible = false;
            }
            else
            {
               param2.filterString = "core.playerNameTxt.GF2";
               Helpers.setTextfieldFormat(param2,{
                  "color":0,
                  "bold":false,
                  "font":LanguageMgr.GetTranslation("songti")
               },true);
               param2.visible = true;
               if(param3)
               {
                  param3.visible = false;
               }
            }
         }
      }
   }
}
