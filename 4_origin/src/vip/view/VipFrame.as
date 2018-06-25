package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import vip.VipController;
   
   public class VipFrame extends Frame
   {
      
      public static const SELF_VIEW:int = 0;
      
      public static const OTHER_VIEW:int = 1;
       
      
      private var _hBox:HBox;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _giveYourselfOpenBtn:SelectedTextButton;
      
      private var _giveOthersOpenedBtn:SelectedTextButton;
      
      private var _vipSp:Disposeable;
      
      private var _head:VipFrameHead;
      
      private var _discountIcon:ScaleLeftRightImage;
      
      private var _discountTxt:FilterFrameText;
      
      private var discountCode:int = 0;
      
      private var _discountIconII:ScaleLeftRightImage;
      
      private var _discountIconIII:ScaleLeftRightImage;
      
      private var _discountTxtII:FilterFrameText;
      
      private var _discountTxtIII:FilterFrameText;
      
      public function VipFrame()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         if(PathManager.vipDiscountEnable)
         {
            discountCode = 1;
         }
         else
         {
            discountCode = 0;
         }
         titleText = LanguageMgr.GetTranslation("ddt.vip.vipFrame.title");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("ddtvip.btnHbox");
         _giveYourselfOpenBtn = ComponentFactory.Instance.creatComponentByStylename("vip.giveYourselfOpenBtn");
         _giveYourselfOpenBtn.text = LanguageMgr.GetTranslation("ddt.vip.table.openSelf");
         _giveOthersOpenedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.giveOthersOpenedBtn");
         _giveOthersOpenedBtn.text = LanguageMgr.GetTranslation("ddt.vip.table.openother");
         _head = new VipFrameHead();
         addToContent(_head);
         addToContent(_hBox);
         _hBox.addChild(_giveYourselfOpenBtn);
         _hBox.addChild(_giveOthersOpenedBtn);
         _selectedButtonGroup = new SelectedButtonGroup(false,1);
         _selectedButtonGroup.addSelectItem(_giveYourselfOpenBtn);
         _selectedButtonGroup.addSelectItem(_giveOthersOpenedBtn);
         _selectedButtonGroup.selectIndex = 0;
         updateView(0);
         _discountIcon = ComponentFactory.Instance.creatComponentByStylename("ddtvip.discount.image");
         addToContent(_discountIcon);
         _discountIconII = ComponentFactory.Instance.creatComponentByStylename("ddtvip.discount.image");
         addToContent(_discountIconII);
         PositionUtils.setPos(_discountIconII,"ddtvip.discount.image.threeMonthPos");
         _discountIconIII = ComponentFactory.Instance.creatComponentByStylename("ddtvip.discount.image");
         addToContent(_discountIconIII);
         PositionUtils.setPos(_discountIconIII,"ddtvip.discount.image.oneMonthPos");
         _discountTxt = ComponentFactory.Instance.creatComponentByStylename("ddtvip.discount.imageTxt");
         addToContent(_discountTxt);
         _discountTxt.x = _discountIcon.x + 1;
         _discountTxt.y = _discountIcon.y + 2;
         _discountTxt.width = _discountIcon.width;
         _discountTxtII = ComponentFactory.Instance.creatComponentByStylename("ddtvip.discount.imageTxt");
         addToContent(_discountTxtII);
         _discountTxtII.x = _discountIconII.x + 1;
         _discountTxtII.y = _discountIconII.y + 2;
         _discountTxtII.width = _discountIconII.width;
         _discountTxtIII = ComponentFactory.Instance.creatComponentByStylename("ddtvip.discount.imageTxt");
         addToContent(_discountTxtIII);
         _discountTxtIII.x = _discountIconIII.x + 1;
         _discountTxtIII.y = _discountIconIII.y + 2;
         _discountTxtIII.width = _discountIconIII.width;
         _discountTxtIII.text = "";
         if(Number(PlayerManager.Instance.vipDiscountArr[2]) > 0)
         {
            _discountTxt.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",100 - PlayerManager.Instance.vipDiscountArr[2] * 10);
         }
         else
         {
            _discountTxt.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",12);
         }
         if(Number(PlayerManager.Instance.vipDiscountArr[1]) > 0)
         {
            _discountTxtII.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",100 - PlayerManager.Instance.vipDiscountArr[1] * 10);
            _discountIconII.visible = true;
         }
         else
         {
            _discountTxtII.text = "";
            _discountIconII.visible = false;
         }
         if(Number(PlayerManager.Instance.vipDiscountArr[0]) > 0)
         {
            _discountTxtIII.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",100 - PlayerManager.Instance.vipDiscountArr[0] * 10);
            _discountIconIII.visible = true;
         }
         else
         {
            _discountTxtIII.text = "";
            _discountIconIII.visible = false;
         }
      }
      
      private function updateView(index:int) : void
      {
         if(_vipSp)
         {
            _vipSp.dispose();
         }
         _vipSp = null;
         switch(int(index))
         {
            case 0:
               _selectedButtonGroup.selectIndex = 0;
               _vipSp = new GiveYourselfOpenView(discountCode);
               break;
            case 1:
               _selectedButtonGroup.selectIndex = 1;
               _vipSp = new GiveOthersOpenedView(false,discountCode);
         }
         var point:Point = ComponentFactory.Instance.creatCustomObject("vip.GiveYourselfOpenViewPos");
         DisplayObject(_vipSp).x = point.x;
         DisplayObject(_vipSp).y = point.y;
         addToContent(DisplayObject(_vipSp));
         DisplayObject(_vipSp).parent.setChildIndex(DisplayObject(_vipSp),0);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _selectedButtonGroup.addEventListener("change",__selectedButtonGroupChange);
      }
      
      private function __selectedButtonGroupChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         updateView(_selectedButtonGroup.selectIndex);
         _hBox.arrange();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         if(_selectedButtonGroup)
         {
            _selectedButtonGroup.removeEventListener("change",__selectedButtonGroupChange);
         }
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               VipController.instance.hide();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_selectedButtonGroup)
         {
            _selectedButtonGroup.dispose();
         }
         _selectedButtonGroup = null;
         if(_giveYourselfOpenBtn)
         {
            ObjectUtils.disposeObject(_giveYourselfOpenBtn);
         }
         _giveYourselfOpenBtn = null;
         if(_giveOthersOpenedBtn)
         {
            ObjectUtils.disposeObject(_giveOthersOpenedBtn);
         }
         _giveOthersOpenedBtn = null;
         if(_discountIcon)
         {
            ObjectUtils.disposeObject(_discountIcon);
         }
         _discountIcon = null;
         if(_discountTxt)
         {
            ObjectUtils.disposeObject(_discountTxt);
         }
         _discountTxt = null;
         if(_discountTxtII)
         {
            ObjectUtils.disposeObject(_discountTxtII);
         }
         _discountTxtII = null;
         if(_discountTxtIII)
         {
            ObjectUtils.disposeObject(_discountTxtIII);
         }
         _discountTxtIII = null;
         if(_discountIconII)
         {
            ObjectUtils.disposeObject(_discountIconII);
         }
         _discountIconII = null;
         if(_discountIconIII)
         {
            ObjectUtils.disposeObject(_discountIconIII);
         }
         _discountIconIII = null;
         if(_head)
         {
            _head.dispose();
            _head = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
