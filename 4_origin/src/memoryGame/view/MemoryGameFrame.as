package memoryGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import invite.InviteManager;
   import memoryGame.MemoryGameManager;
   
   public class MemoryGameFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _selectedBtnsHBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _gameBtn:SelectedButton;
      
      private var _rewardsBtn:SelectedButton;
      
      private var _gameView:MemoryGameView;
      
      private var _shopView:MemoryGameShop;
      
      private var _btnHelp:BaseButton;
      
      public function MemoryGameFrame()
      {
         super();
         initEvent();
         checkActivity();
      }
      
      override protected function init() : void
      {
         InviteManager.Instance.enabled = false;
         _bg = ComponentFactory.Instance.creatComponentByStylename("memoryGame.MemoryGameFrame.bg");
         _gameBtn = ComponentFactory.Instance.creatComponentByStylename("memoryGame.gameBtn");
         _rewardsBtn = ComponentFactory.Instance.creatComponentByStylename("memoryGame.scoreBtn");
         _selectedBtnsHBox = ComponentFactory.Instance.creatComponentByStylename("memoryGame.MemoryGameFrame.hBox");
         _btnGroup = new SelectedButtonGroup();
         _selectedBtnsHBox.addChild(_gameBtn);
         _selectedBtnsHBox.addChild(_rewardsBtn);
         _btnGroup.addSelectItem(_gameBtn);
         _btnGroup.addSelectItem(_rewardsBtn);
         _btnGroup.selectIndex = 0;
         super.init();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":718,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.memoryGame.view.help",408,488);
         titleText = LanguageMgr.GetTranslation("memoryGame.title");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_selectedBtnsHBox)
         {
            addToContent(_selectedBtnsHBox);
         }
         if(_gameView)
         {
            addToContent(_gameView);
         }
         if(_shopView)
         {
            addToContent(_shopView);
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         if(MemoryGameManager.instance.playActionAllComplete() && !MemoryGameManager.instance.turning)
         {
            dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.notClose"));
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(!_gameView)
               {
                  _gameView = new MemoryGameView(this);
                  SocketManager.Instance.out.sendMemoryGameInfo();
                  PositionUtils.setPos(_gameView,"memoryGame.gameViewPos");
               }
               if(_shopView)
               {
                  _shopView.visible = false;
               }
               _gameView.visible = true;
               break;
            case 1:
               if(!_shopView)
               {
                  _shopView = new MemoryGameShop();
                  PositionUtils.setPos(_shopView,"memoryGame.shopViewPos");
               }
               if(_gameView)
               {
                  _gameView.visible = false;
               }
               _shopView.visible = true;
               _shopView.update();
         }
         addChildren();
      }
      
      public function shopViewUpdate() : void
      {
         if(_shopView)
         {
            _shopView.update();
         }
      }
      
      private function checkActivity() : void
      {
         var _loc1_:Boolean = MemoryGameManager.instance.isValid;
         __changeHandler(null);
         if(!_loc1_)
         {
            _gameBtn.enable = false;
            _btnGroup.selectIndex = 1;
         }
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
      }
      
      override public function dispose() : void
      {
         InviteManager.Instance.enabled = true;
         removeEvent();
         ObjectUtils.disposeObject(_btnHelp);
         super.dispose();
         _bg = null;
         _gameView = null;
         _shopView = null;
         _selectedBtnsHBox = null;
         _btnHelp = null;
      }
   }
}
