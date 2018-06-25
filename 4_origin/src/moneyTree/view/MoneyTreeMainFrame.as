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
         var i:int = 0;
         var fruit:* = null;
         super.init();
         escEnable = true;
         var factary:ComponentFactory = ComponentFactory.Instance;
         titleText = LanguageMgr.GetTranslation("moneyTree.title");
         var moenyTreeHelpContent:Sprite = ComponentFactory.Instance.creat("moneyTree.help");
         PositionUtils.setPos(moenyTreeHelpContent,"moneytree.HelpContentPos");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"moneytree.helpBtn",null,LanguageMgr.GetTranslation("moneytree.helpTitle"),moenyTreeHelpContent,404,484) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,"moneytree.helpBtnPos");
         _bg = factary.creatBitmap("moneyTree.bg");
         _bg.x = 16;
         _bg.y = 42;
         addToContent(_bg);
         _bgMC = factary.creat("moneyTree.bg.movie");
         _bgMC.x = 64;
         _bgMC.y = 311;
         addToContent(_bgMC);
         for(i = 0; i < 4; )
         {
            fruit = new Fruit(i);
            PositionUtils.setPos(fruit,"moneyTree.fruit" + i.toString() + ".pos");
            addToContent(fruit);
            _fruitList[i] = fruit;
            i++;
         }
         _listBG = ComponentFactory.Instance.creatComponentByStylename("asset.horseracing.bg");
         _listBG.x = 344;
         _listBG.y = 132;
         addToContent(_listBG);
         _friendsListPanel = factary.creatComponentByStylename("moneyTree.ui.FriendsList");
         addToContent(_friendsListPanel);
         _listPanelMediator = new ListPanelMediator();
         _listPanelMediator.setPanel(_friendsListPanel);
         _listPanelMediator.refresh(0);
         _txtRemainNum = factary.creat("moneyTree.txt.TimesRemain");
         addToContent(_txtRemainNum);
         _txtRemainNum.text = "";
         _btnSend = factary.creat("moneyTree.btn.send");
         addToContent(_btnSend);
         _btnSend.addEventListener("click",onSendClick);
         addEventListener("response",_response);
      }
      
      public function pick(index:int) : void
      {
         _fruitList[index].showPick();
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
         var i:int = 0;
         var data:* = null;
         var model:MoneyTreeModel = MoneyTreeManager.getInstance().model;
         var len:int = _fruitList.length;
         for(i = 0; i < len; )
         {
            data = model.getInfoAt(i);
            if(data.isGrown)
            {
               _fruitList[i].showGrown();
            }
            else
            {
               _fruitList[i].showNormal();
            }
            i++;
         }
      }
      
      protected function onSendClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         MoneyTreeManager.getInstance().sendRedPkgBtnClicked();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
      
      protected function onRedPkgShine(e:Event) : void
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
      
      protected function onShineEF(event:Event) : void
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
