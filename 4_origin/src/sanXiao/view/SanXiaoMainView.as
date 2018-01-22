package sanXiao.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonForArrange;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperHelpBtnCreate;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import sanXiao.SanXiaoManager;
   
   public class SanXiaoMainView extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _selectGridBox:HBox;
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var _btnGame:SelectedButtonForArrange;
      
      private var _btnStore:SelectedButtonForArrange;
      
      private var _btnDetail:SelectedButtonForArrange;
      
      private var _viewGame:SanXiaoViewGame;
      
      private var _viewStore:SanXiaoViewStore;
      
      private var _viewDetail:SanXiaoViewDetail;
      
      private var _curView:Sprite;
      
      private var _help:HelperHelpBtnCreate;
      
      public function SanXiaoMainView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("sanxiao.title");
         autoExit = true;
         escEnable = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("sanxiao.bg");
         addToContent(_bg);
         _viewGame = new SanXiaoViewGame();
         _viewStore = new SanXiaoViewStore();
         _viewDetail = new SanXiaoViewDetail();
         PositionUtils.setPos(_viewGame,"sanxiao.page.pt");
         PositionUtils.setPos(_viewStore,"sanxiao.page.pt");
         PositionUtils.setPos(_viewDetail,"sanxiao.page.pt");
         _selectGridBox = new HBox();
         PositionUtils.setPos(_selectGridBox,"sanxiao.btns.pt");
         _selectGroup = new SelectedButtonGroup();
         _btnGame = ComponentFactory.Instance.creat("sanxiao.gameBtn");
         _btnStore = ComponentFactory.Instance.creat("sanxiao.storeBtn");
         _btnDetail = ComponentFactory.Instance.creat("sanxiao.detailBtn");
         _selectGroup.addSelectItem(_btnGame);
         _selectGroup.addSelectItem(_btnStore);
         _selectGroup.addSelectItem(_btnDetail);
         _selectGridBox.addChild(_btnGame);
         _selectGridBox.addChild(_btnStore);
         _selectGridBox.addChild(_btnDetail);
         addToContent(_selectGridBox);
         _help = new HelperHelpBtnCreate();
         _help.create(this,"ast.sanxiao.help",null,new Point(705,6),LanguageMgr.GetTranslation("AlertDialog.help"));
         addEvents();
         if(SanXiaoManager.getInstance().endTime.time <= TimeManager.Instance.Now().time)
         {
            Helpers.grey(_btnGame);
            _selectGroup.selectIndex = 1;
         }
         else
         {
            Helpers.colorful(_btnGame);
            _selectGroup.selectIndex = 0;
         }
      }
      
      private function addEvents() : void
      {
         _btnGame.addEventListener("click",onBtnClick);
         _btnStore.addEventListener("click",onBtnClick);
         _btnDetail.addEventListener("click",onBtnClick);
         _selectGroup.addEventListener("change",onSelectGroupChange);
      }
      
      private function removeEvents() : void
      {
         _btnGame.removeEventListener("click",onBtnClick);
         _btnStore.removeEventListener("click",onBtnClick);
         _btnDetail.removeEventListener("click",onBtnClick);
         _selectGroup.removeEventListener("change",onSelectGroupChange);
      }
      
      protected function onBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function onSelectGroupChange(param1:Event) : void
      {
         _viewGame.parent && _container.removeChild(_viewGame);
         _viewStore.parent && _container.removeChild(_viewStore);
         _viewDetail.parent && _container.removeChild(_viewDetail);
         switch(int(_selectGroup.selectIndex))
         {
            case 0:
               if(SanXiaoManager.getInstance().endTime.time <= TimeManager.Instance.Now().time)
               {
                  Helpers.grey(_btnGame);
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("sanxiao.timesOut"),0,true);
                  _selectGroup.selectIndex = 1;
                  return;
               }
               Helpers.colorful(_btnGame);
               addToContent(_viewGame);
               _viewGame.update();
               break;
            case 1:
               addToContent(_viewStore);
               _viewStore.update();
               break;
            case 2:
               addToContent(_viewDetail);
               _viewDetail.update();
         }
         _selectGridBox.arrange();
      }
      
      public function lockProps() : void
      {
      }
      
      public function unLockProps() : void
      {
      }
      
      public function updateDropOutItem() : void
      {
      }
      
      public function update() : void
      {
         _viewGame && _viewGame.parent && _viewGame.update();
         _viewStore && _viewStore.parent && _viewStore.update();
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _help.dispose();
         _help = null;
         ObjectUtils.disposeObject(_viewDetail);
         ObjectUtils.disposeObject(_viewGame);
         ObjectUtils.disposeObject(_viewStore);
         ObjectUtils.disposeObject(_selectGroup);
         ObjectUtils.disposeObject(_selectGridBox);
         _viewDetail = null;
         _viewGame = null;
         _viewStore = null;
         _selectGroup = null;
         _selectGridBox = null;
         super.dispose();
      }
   }
}
