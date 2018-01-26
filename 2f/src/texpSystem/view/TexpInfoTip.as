package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   
   public class TexpInfoTip extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      private const NAME_COLOR:Array = ["#24e198","#f33232","#36baff","#69e000","#ffae00","#fd00e7","#a57bfe"];
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _txtTitle:FilterFrameText;
      
      private var _txtContent:FilterFrameText;
      
      private var _tipWidth:int;
      
      private var _tipHeight:int;
      
      private var _tipData:PlayerInfo;
      
      public function TexpInfoTip(){super();}
      
      private function init() : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      private function getHtmlText(param1:TexpInfo) : String{return null;}
      
      public function dispose() : void{}
   }
}
