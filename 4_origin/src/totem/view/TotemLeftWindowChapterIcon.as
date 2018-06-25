package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import totem.TotemControl;
   import totem.TotemManager;
   import totem.data.TotemChapterTipInfo;
   import totem.data.TotemDataVo;
   
   public class TotemLeftWindowChapterIcon extends Sprite implements Disposeable
   {
       
      
      private var _iconList:Vector.<Bitmap>;
      
      private var _iconSprite:Sprite;
      
      private var _icon:Bitmap;
      
      private var _upBtn:BaseButton;
      
      private var _page:int;
      
      private var _cell:TotemTabItemCell;
      
      private var _isSelf:Boolean = false;
      
      private var _fromType:int = -1;
      
      private var _playerInfo:PlayerInfo;
      
      public function TotemLeftWindowChapterIcon(page:int, playerInfo:PlayerInfo, fromType:int)
      {
         _playerInfo = playerInfo;
         _isSelf = playerInfo.isSelf;
         _fromType = fromType;
         super();
         _page = page;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _cell = new TotemTabItemCell();
         addChild(_cell);
         _cell.quality = getQulity;
         _cell.chapter = page;
         _iconSprite = new Sprite();
         addEventListener("mouseOver",showTip,false,0,true);
         addEventListener("mouseOut",hideTip,false,0,true);
         addChild(_iconSprite);
         _iconSprite.addChild(_cell);
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("Totem.upGrades.btn");
         addChild(_upBtn);
         _upBtn.visible = false;
      }
      
      private function get getQulity() : int
      {
         var temValue:int = 1;
         if(_isSelf)
         {
            temValue = TotemControl.instance.getGradeByTotemPage(page);
         }
         else
         {
            temValue = _playerInfo.getTotemGradeByID(page);
         }
         return temValue;
      }
      
      public function updateQuality() : void
      {
         _cell.quality = getQulity;
      }
      
      public function set disable(value:Boolean) : void
      {
         if(value)
         {
            this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            this.filters = [];
         }
         this.mouseEnabled = !value;
         this.mouseChildren = !value;
      }
      
      public function set upBtnVisble(value:Boolean) : void
      {
         _upBtn.visible = value;
      }
      
      private function __upGradesHandler(evt:MouseEvent) : void
      {
         var nextInfo:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         if(nextInfo && nextInfo.Layers == 1 && nextInfo.Location == 1 && nextInfo.Page == page)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.upGrade.totemNoActive"));
            return;
         }
         var upView:TotemUpGradeView = new TotemUpGradeView(page);
         upView.show();
      }
      
      private function addEvents() : void
      {
         if(_upBtn)
         {
            _upBtn.addEventListener("click",__upGradesHandler);
         }
      }
      
      private function removeEvents() : void
      {
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upGradesHandler);
         }
      }
      
      public function set tipData(info:TotemChapterTipInfo) : void
      {
         _cell.tipData = info;
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      private function showTip(event:MouseEvent) : void
      {
         upBtnVisble = _fromType == 2;
      }
      
      private function hideTip(event:MouseEvent) : void
      {
         upBtnVisble = false;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_iconSprite)
         {
            removeEventListener("mouseOver",showTip);
            removeEventListener("mouseOut",hideTip);
         }
         if(_cell)
         {
            _cell.dispose();
         }
         _cell = null;
         ObjectUtils.disposeAllChildren(this);
         _iconSprite = null;
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
