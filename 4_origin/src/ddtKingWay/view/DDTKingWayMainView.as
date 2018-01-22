package ddtKingWay.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddtKingWay.DDTKingWayManager;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   
   public class DDTKingWayMainView extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _bgItem:Image;
      
      private var _btnHelp:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _prevBtn:BaseButton;
      
      private var _leftView:DDTKingWayLevelView;
      
      private var _HBox:HBox;
      
      private var _item:ScaleFrameImage;
      
      private var _list:Vector.<ScaleFrameImage>;
      
      private var _index:int;
      
      private var _maxIndex:int;
      
      private var _currentGradeIndex:int;
      
      public function DDTKingWayMainView()
      {
         super();
         InviteManager.Instance.enabled = false;
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super.init();
         _bgItem = ComponentFactory.Instance.creatComponentByStylename("ddtKingWay.bgItem");
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.MainBg");
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":753,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.ddtKingWay.view.help",450,350);
         _leftView = new DDTKingWayLevelView();
         _index = DDTKingWayManager.instance.getPageIndexByGrade(PlayerManager.Instance.Self.Grade);
         _currentGradeIndex = _index + 1;
         if(PlayerManager.Instance.Self.Grade >= 70)
         {
            _maxIndex = _index + 1;
         }
         else
         {
            _maxIndex = _index + 2;
         }
         _list = new Vector.<ScaleFrameImage>();
         _loc2_ = 0;
         while(_loc2_ <= _maxIndex && _loc2_ < DDTKingWayManager.QUEST_LIST.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.levelItemBg" + (_loc2_ + 3));
            _list[_loc2_] = _loc1_;
            _loc2_++;
         }
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKingWay.nextBtn");
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKingWay.prevBtn");
         _nextBtn.addEventListener("click",__onClickNext);
         _prevBtn.addEventListener("click",__onClickPrev);
         _HBox = ComponentFactory.Instance.creatComponentByStylename("asset.ddtKingWay.levelItemhbox");
         updateView();
      }
      
      private function __onClickNext(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _index = _index + 1;
         updateView();
      }
      
      private function __onClickPrev(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _index = _index - 1;
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _prevBtn.enable = true;
         _nextBtn.enable = true;
         if(_index == 0)
         {
            _prevBtn.enable = false;
         }
         if(_maxIndex == _index + 1)
         {
            _nextBtn.enable = false;
         }
         _HBox.removeAllChild();
         _loc2_ = 0;
         while(_loc2_ <= _maxIndex && _loc2_ < DDTKingWayManager.QUEST_LIST.length)
         {
            if(Math.abs(_loc2_ - _index) <= 1)
            {
               _loc1_ = _list[_loc2_];
               if(_loc2_ == _index)
               {
                  _loc1_.setFrame(2);
               }
               else
               {
                  _loc1_.setFrame(1);
               }
               _HBox.addChild(_loc1_);
            }
            _loc2_++;
         }
         _HBox.arrange();
         if(_index == 0)
         {
            PositionUtils.setPos(_HBox,"asset.ddtKingWay.levelItemPos2");
         }
         else
         {
            PositionUtils.setPos(_HBox,"asset.ddtKingWay.levelItemPos1");
         }
         if(_currentGradeIndex <= _index)
         {
            _leftView.updataView(DDTKingWayManager.instance.model[DDTKingWayManager.QUEST_LIST[_index]],false);
         }
         else
         {
            _leftView.updataView(DDTKingWayManager.instance.model[DDTKingWayManager.QUEST_LIST[_index]],true);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_bgItem)
         {
            addToContent(_bgItem);
         }
         if(_btnHelp)
         {
            addToContent(_btnHelp);
         }
         if(_HBox)
         {
            addToContent(_HBox);
         }
         if(_nextBtn)
         {
            addToContent(_nextBtn);
         }
         if(_prevBtn)
         {
            addToContent(_prevBtn);
         }
         if(_leftView)
         {
            addToContent(_leftView);
         }
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.playButtonSound();
         DDTKingWayManager.instance.closeFrame();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         InviteManager.Instance.enabled = true;
         _nextBtn.removeEventListener("click",__onClickNext);
         _prevBtn.removeEventListener("click",__onClickPrev);
         ObjectUtils.disposeObject(_btnHelp);
         _loc1_ = 0;
         while(_loc1_ < _list.length)
         {
            _list[_loc1_].dispose();
            _loc1_++;
         }
         if(_HBox)
         {
            _HBox.disposeAllChildren();
         }
         super.dispose();
         _btnHelp = null;
         _bg = null;
         _bgItem = null;
         _HBox = null;
         _leftView = null;
      }
   }
}
