package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import texpSystem.controller.TexpManager;
   
   public class TexpInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg1:MovieImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _bg3:Scale9CornerImage;
      
      private var _bg4:Bitmap;
      
      private var _bg5:Bitmap;
      
      private var _txtBg1:Bitmap;
      
      private var _txtBg2:Bitmap;
      
      private var _txtBg3:Bitmap;
      
      private var _txtBg4:Bitmap;
      
      private var _txtBg5:Bitmap;
      
      private var _bmpHp:Bitmap;
      
      private var _bmpAtt:Bitmap;
      
      private var _bmpDef:Bitmap;
      
      private var _bmpSpd:Bitmap;
      
      private var _bmpLuk:Bitmap;
      
      private var _txtAttEff:FilterFrameText;
      
      private var _txtDefEff:FilterFrameText;
      
      private var _txtHpEff:FilterFrameText;
      
      private var _txtLukEff:FilterFrameText;
      
      private var _txtSpdEff:FilterFrameText;
      
      private var _btnHpIcon:BaseButton;
      
      private var _btnAttIcon:BaseButton;
      
      private var _btnDefIcon:BaseButton;
      
      private var _btnSpdIcon:BaseButton;
      
      private var _btnLukIcon:BaseButton;
      
      private var _info:PlayerInfo;
      
      public function TexpInfoView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function getX(param1:FilterFrameText, param2:Bitmap) : Number{return 0;}
      
      public function set info(param1:PlayerInfo) : void{}
      
      public function dispose() : void{}
   }
}
