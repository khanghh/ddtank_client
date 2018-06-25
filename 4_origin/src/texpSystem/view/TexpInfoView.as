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
      
      public function TexpInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg1");
         addChild(_bg1);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg2");
         addChild(_bg2);
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg3");
         addChild(_bg3);
         _bg4 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.bg4");
         addChild(_bg4);
         _bg5 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.bg5");
         addChild(_bg5);
         _txtBg1 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.infoTxtBg");
         PositionUtils.setPos(_txtBg1,"texpSystem.posInfoTxtBg1");
         addChild(_txtBg1);
         _txtBg2 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.infoTxtBg");
         PositionUtils.setPos(_txtBg2,"texpSystem.posInfoTxtBg2");
         addChild(_txtBg2);
         _txtBg3 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.infoTxtBg");
         PositionUtils.setPos(_txtBg3,"texpSystem.posInfoTxtBg3");
         addChild(_txtBg3);
         _txtBg4 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.infoTxtBg");
         PositionUtils.setPos(_txtBg4,"texpSystem.posInfoTxtBg4");
         addChild(_txtBg4);
         _txtBg5 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.infoTxtBg");
         PositionUtils.setPos(_txtBg5,"texpSystem.posInfoTxtBg5");
         addChild(_txtBg5);
         _bmpHp = ComponentFactory.Instance.creatBitmap("asset.texpSystem.txtHp");
         addChild(_bmpHp);
         _bmpAtt = ComponentFactory.Instance.creatBitmap("asset.texpSystem.txtAtt");
         addChild(_bmpAtt);
         _bmpDef = ComponentFactory.Instance.creatBitmap("asset.texpSystem.txtDef");
         addChild(_bmpDef);
         _bmpSpd = ComponentFactory.Instance.creatBitmap("asset.texpSystem.txtSpd");
         addChild(_bmpSpd);
         _bmpLuk = ComponentFactory.Instance.creatBitmap("asset.texpSystem.txtLuk");
         addChild(_bmpLuk);
         _txtAttEff = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtAttEff");
         addChild(_txtAttEff);
         _txtDefEff = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtDefEff");
         addChild(_txtDefEff);
         _txtHpEff = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtHpEff");
         addChild(_txtHpEff);
         _txtLukEff = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtLukEff");
         addChild(_txtLukEff);
         _txtSpdEff = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtSpdEff");
         addChild(_txtSpdEff);
         _btnHpIcon = ComponentFactory.Instance.creatComponentByStylename("texpSystem.hp2");
         _btnHpIcon.useHandCursor = false;
         addChild(_btnHpIcon);
         _btnAttIcon = ComponentFactory.Instance.creatComponentByStylename("texpSystem.att2");
         _btnAttIcon.useHandCursor = false;
         addChild(_btnAttIcon);
         _btnDefIcon = ComponentFactory.Instance.creatComponentByStylename("texpSystem.def2");
         _btnDefIcon.useHandCursor = false;
         addChild(_btnDefIcon);
         _btnSpdIcon = ComponentFactory.Instance.creatComponentByStylename("texpSystem.spd2");
         _btnSpdIcon.useHandCursor = false;
         addChild(_btnSpdIcon);
         _btnLukIcon = ComponentFactory.Instance.creatComponentByStylename("texpSystem.luk2");
         _btnLukIcon.useHandCursor = false;
         addChild(_btnLukIcon);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function getX(txt:FilterFrameText, bg:Bitmap) : Number
      {
         return bg.x + (bg.width - txt.width) / 2;
      }
      
      public function set info(value:PlayerInfo) : void
      {
         if(!value)
         {
            return;
         }
         _info = value;
         _txtAttEff.text = TexpManager.Instance.getInfo(1,_info.attTexpExp).currEffect.toString();
         _txtAttEff.x = getX(_txtAttEff,_txtBg1);
         _txtDefEff.text = TexpManager.Instance.getInfo(2,_info.defTexpExp).currEffect.toString();
         _txtDefEff.x = getX(_txtDefEff,_txtBg2);
         _txtHpEff.text = TexpManager.Instance.getInfo(0,_info.hpTexpExp).currEffect.toString();
         _txtHpEff.x = getX(_txtHpEff,_txtBg3);
         _txtLukEff.text = TexpManager.Instance.getInfo(4,_info.lukTexpExp).currEffect.toString();
         _txtLukEff.x = getX(_txtLukEff,_txtBg4);
         _txtSpdEff.text = TexpManager.Instance.getInfo(3,_info.spdTexpExp).currEffect.toString();
         _txtSpdEff.x = getX(_txtSpdEff,_txtBg5);
         _btnHpIcon.tipData = TexpManager.Instance.getInfo(0,_info.hpTexpExp);
         _btnAttIcon.tipData = TexpManager.Instance.getInfo(1,_info.attTexpExp);
         _btnDefIcon.tipData = TexpManager.Instance.getInfo(2,_info.defTexpExp);
         _btnSpdIcon.tipData = TexpManager.Instance.getInfo(3,_info.spdTexpExp);
         _btnLukIcon.tipData = TexpManager.Instance.getInfo(4,_info.lukTexpExp);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg1 = null;
         _bg2 = null;
         _bg3 = null;
         _bg4 = null;
         _bg5 = null;
         _txtBg1 = null;
         _txtBg2 = null;
         _txtBg3 = null;
         _txtBg4 = null;
         _txtBg5 = null;
         _bmpHp = null;
         _bmpAtt = null;
         _bmpDef = null;
         _bmpSpd = null;
         _bmpLuk = null;
         _txtAttEff = null;
         _txtDefEff = null;
         _txtHpEff = null;
         _txtLukEff = null;
         _txtSpdEff = null;
         _btnHpIcon = null;
         _btnAttIcon = null;
         _btnDefIcon = null;
         _btnSpdIcon = null;
         _btnLukIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
