package moneyTree.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import moneyTree.MoneyTreeManager;
   import moneyTree.model.MT_FruitData;
   import moneyTree.model.MoneyTreeModel;
   import moneyTree.ui.ListPanelMediator;
   
   public class MoneyTreeMainFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bgMC:MovieClip;
      
      private var _fruitList:Vector.<Fruit>;
      
      private var _txtRemainNum:FilterFrameText;
      
      private var _btnSend:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _leafs:Bitmap;
      
      private var _friendsListPanel:ListPanel;
      
      private var _listBG:MutipleImage;
      
      private var _listPanelMediator:ListPanelMediator;
      
      private var _shineMC:MovieClip;
      
      private var _redPkgShineMC:MovieClip;
      
      public function MoneyTreeMainFrame()
      {
         _fruitList = new Vector.<Fruit>();
         super();
      }
      
      override protected function init() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         super.init();
         escEnable = true;
         var _loc3_:ComponentFactory = ComponentFactory.Instance;
         titleText = LanguageMgr.GetTranslation("moneyTree.title");
         var _loc2_:Sprite = ComponentFactory.Instance.creat("moneyTree.help");
         PositionUtils.setPos(_loc2_,"moneytree.HelpContentPos");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"moneytree.helpBtn",null,LanguageMgr.GetTranslation("moneytree.helpTitle"),_loc2_,404,484) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,"moneytree.helpBtnPos");
         _bg = _loc3_.creatBitmap("moneyTree.bg");
         _bg.x = 16;
         _bg.y = 42;
         addToContent(_bg);
         _bgMC = _loc3_.creat("moneyTree.bg.movie");
         _bgMC.x = 64;
         _bgMC.y = 311;
         addToContent(_bgMC);
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc1_ = new Fruit(_loc4_);
            PositionUtils.setPos(_loc1_,"moneyTree.fruit" + _loc4_.toString() + ".pos");
            addToContent(_loc1_);
            _fruitList[_loc4_] = _loc1_;
            _loc4_++;
         }
         _listBG = ComponentFactory.Instance.creatComponentByStylename("asset.horseracing.bg");
         _listBG.x = 344;
         _listBG.y = 132;
         addToContent(_listBG);
         _friendsListPanel = _loc3_.creatComponentByStylename("moneyTree.ui.FriendsList");
         addToContent(_friendsListPanel);
         _listPanelMediator = new ListPanelMediator();
         _listPanelMediator.setPanel(_friendsListPanel);
         _listPanelMediator.refresh(0);
         _txtRemainNum = _loc3_.creat("moneyTree.txt.TimesRemain");
         addToContent(_txtRemainNum);
         _txtRemainNum.text = "";
         _btnSend = _loc3_.creat("moneyTree.btn.send");
         addToContent(_btnSend);
         _btnSend.addEventListener("click",onSendClick);
         addEventListener("response",_response);
      }
      
      public function pick(param1:int) : void
      {
         _fruitList[param1].showPick();
      }
      
      public function resetFriendList() : void
      {
         _listPanelMediator.reset();
      }
      
      public function updateRemainNum() : void
      {
         _txtRemainNum.text = MoneyTreeManager.getInstance().model.getNumRedPkgRemain().toString();
      }
      
      public function updateFruits() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:MoneyTreeModel = MoneyTreeManager.getInstance().model;
         var _loc3_:int = _fruitList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc1_.getInfoAt(_loc4_);
            if(_loc2_.isGrown)
            {
               _fruitList[_loc4_].showGrown();
            }
            else
            {
               _fruitList[_loc4_].showNormal();
            }
            _loc4_++;
         }
      }
      
      protected function onSendClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         MoneyTreeManager.getInstance().sendRedPkgBtnClicked();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            MoneyTreeManager.getInstance().hideMainFrame();
         }
      }
      
      public function playFly() : void
      {
         var _loc1_:Boolean = false;
         this.mouseEnabled = _loc1_;
         this.mouseChildren = _loc1_;
         this.escEnable = false;
         if(!_redPkgShineMC)
         {
            _redPkgShineMC = ComponentFactory.Instance.creat("moneyTree.redPkg.shining");
            _redPkgShineMC.x = 375;
            _redPkgShineMC.y = 89;
         }
         if(!_shineMC)
         {
            _shineMC = ComponentFactory.Instance.creat("moneyTree.lightsFly");
            _shineMC.x = 135;
            _shineMC.y = 171;
         }
         addToContent(_shineMC);
         _shineMC.addEventListener("enterFrame",onShineEF);
         _shineMC.gotoAndPlay(1);
         addToContent(_redPkgShineMC);
         _redPkgShineMC.addEventListener("enterFrame",onRedPkgShine);
         _redPkgShineMC.gotoAndPlay(1);
      }
      
      protected function onRedPkgShine(param1:Event) : void
      {
         if(_redPkgShineMC.currentFrame == _redPkgShineMC.totalFrames)
         {
            _redPkgShineMC.removeEventListener("enterFrame",onRedPkgShine);
            _redPkgShineMC.parent && _container.removeChild(_redPkgShineMC);
            _redPkgShineMC.stop();
            var _loc2_:Boolean = true;
            this.mouseEnabled = _loc2_;
            this.mouseChildren = _loc2_;
            this.escEnable = true;
         }
      }
      
      protected function onShineEF(param1:Event) : void
      {
         if(_shineMC.currentFrame == _shineMC.totalFrames)
         {
            _shineMC.removeEventListener("enterFrame",onShineEF);
            _shineMC.parent && _container.removeChild(_shineMC);
            _shineMC.stop();
            var _loc2_:Boolean = true;
            this.mouseEnabled = _loc2_;
            this.mouseChildren = _loc2_;
            this.escEnable = true;
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         if(_shineMC)
         {
            _shineMC.removeEventListener("enterFrame",onShineEF);
            _shineMC.stop();
            ObjectUtils.disposeObject(_shineMC);
            _shineMC = null;
         }
         if(_redPkgShineMC)
         {
            _redPkgShineMC.removeEventListener("enterFrame",onRedPkgShine);
            _redPkgShineMC.stop();
            ObjectUtils.disposeObject(_redPkgShineMC);
            _redPkgShineMC = null;
         }
         if(_btnSend != null)
         {
            _btnSend.removeEventListener("click",onSendClick);
            ObjectUtils.disposeObject(_btnSend);
            _btnSend = null;
         }
         super.dispose();
      }
   }
}
