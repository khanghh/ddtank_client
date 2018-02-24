package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ToolPropTip extends BaseTip
   {
       
      
      private var _info:ItemTemplateInfo;
      
      private var _count:int = 0;
      
      private var _showTurn:Boolean;
      
      private var _showCount:Boolean;
      
      private var _showThew:Boolean;
      
      private var _bg:ScaleBitmapImage;
      
      private var context:TextField;
      
      private var thew_txt:FilterFrameText;
      
      private var turn_txt:FilterFrameText;
      
      private var description_txt:FilterFrameText;
      
      private var name_txt:FilterFrameText;
      
      private var _tempData:Object;
      
      private var f:TextFormat;
      
      private var _container:Sprite;
      
      public function ToolPropTip(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      public function changeStyle(param1:ItemTemplateInfo, param2:int, param3:Boolean = true) : void{}
      
      private function update(param1:Boolean, param2:Boolean, param3:Boolean, param4:String, param5:ItemTemplateInfo, param6:int, param7:String) : void{}
      
      private function reset() : void{}
      
      private function drawBG(param1:int = 0) : void{}
      
      override public function dispose() : void{}
   }
}
