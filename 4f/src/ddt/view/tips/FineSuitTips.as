package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.store.FineSuitVo;
   import ddt.manager.FineSuitManager;
   import ddt.manager.LanguageMgr;
   
   public class FineSuitTips extends BaseTip
   {
       
      
      private var _title:FilterFrameText;
      
      private var suitType:Array;
      
      private var _itemList:Vector.<FineSuitTipsItem>;
      
      private var _textList:Vector.<FilterFrameText>;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      public function FineSuitTips(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateTipsView() : void{}
      
      private function getItmeContent(param1:int, param2:int) : String{return null;}
      
      private function setBackgoundWidth(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
