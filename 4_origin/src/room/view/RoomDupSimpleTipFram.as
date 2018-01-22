package room.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RoomDupSimpleTipFram extends BaseAlerFrame
   {
       
      
      private var _view:Sprite;
      
      private var _bg:Bitmap;
      
      private var _dupTip:FilterFrameText;
      
      private var _newEnemy:FilterFrameText;
      
      private var _boguBoss:FilterFrameText;
      
      private var _moreGoods:FilterFrameText;
      
      private var _goodsI:FilterFrameText;
      
      private var _goodsII:FilterFrameText;
      
      private var _goodsIII:FilterFrameText;
      
      private var _goodsIV:FilterFrameText;
      
      public function RoomDupSimpleTipFram()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _view = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.room.view.BoGuTipAsset");
         _dupTip = ComponentFactory.Instance.creatComponentByStylename("room.BoGuTip");
         _boguBoss = ComponentFactory.Instance.creatComponentByStylename("room.BoGuBoss");
         _newEnemy = ComponentFactory.Instance.creatComponentByStylename("room.BoGuNewEnemy");
         _moreGoods = ComponentFactory.Instance.creatComponentByStylename("room.BoGuMoreGoods");
         _goodsI = ComponentFactory.Instance.creatComponentByStylename("room.BoGuGoodsI");
         _goodsII = ComponentFactory.Instance.creatComponentByStylename("room.BoGuGoodsII");
         _goodsIII = ComponentFactory.Instance.creatComponentByStylename("room.BoGuGoodsIII");
         _goodsIV = ComponentFactory.Instance.creatComponentByStylename("room.BoGuGoodsIV");
         _dupTip.text = LanguageMgr.GetTranslation("ddt.room.boguTip");
         _newEnemy.text = LanguageMgr.GetTranslation("ddt.room.boguNewEnemy");
         _boguBoss.text = LanguageMgr.GetTranslation("ddt.room.boguBoss");
         _moreGoods.text = LanguageMgr.GetTranslation("ddt.room.boguMoreGoods");
         _goodsI.text = LanguageMgr.GetTranslation("ddt.room.boguGoods1");
         _goodsII.text = LanguageMgr.GetTranslation("ddt.room.boguGoods2");
         _goodsIII.text = LanguageMgr.GetTranslation("ddt.room.boguGoods3");
         _goodsIV.text = LanguageMgr.GetTranslation("ddt.room.boguGoods4");
         _view.addChild(_bg);
         _view.addChild(_dupTip);
         _view.addChild(_newEnemy);
         _view.addChild(_boguBoss);
         _view.addChild(_moreGoods);
         _view.addChild(_goodsI);
         _view.addChild(_goodsII);
         _view.addChild(_goodsIII);
         _view.addChild(_goodsIV);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function show() : void
      {
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.data = _view;
         _loc1_.showCancel = false;
         _loc1_.moveEnable = false;
         info = _loc1_;
         addToContent(_view);
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         super.dispose();
         _view = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
