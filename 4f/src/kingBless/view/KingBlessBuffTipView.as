package kingBless.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   
   public class KingBlessBuffTipView extends BaseTip
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _valueTxtList:Vector.<FilterFrameText>;
      
      private var _tipTxt:FilterFrameText;
      
      private var _valueNameList:Array;
      
      public function KingBlessBuffTipView(){super();}
      
      override public function set tipData(param1:Object) : void{}
      
      private function updateSize() : void{}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      override public function dispose() : void{}
   }
}
