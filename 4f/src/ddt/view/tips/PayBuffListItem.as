package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class PayBuffListItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:DisplayObject;
      
      private var _labelField:FilterFrameText;
      
      private var _timeField:FilterFrameText;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _countField:FilterFrameText;
      
      private var levelDic:Dictionary;
      
      private var fightBuffClass;
      
      public function PayBuffListItem(param1:*){super();}
      
      private function initLevelDic() : void{}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
