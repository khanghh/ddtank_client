package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BadgeInfoManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BadgeShopPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _levelBtn1:SelectedTextButton;
      
      private var _levelBtn2:SelectedTextButton;
      
      private var _levelBtn3:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:BadgeShopList;
      
      public function BadgeShopPanel()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.shopBadge.bg");
         addChild(_bg);
         _levelBtn1 = ComponentFactory.Instance.creatComponentByStylename("consortion.levelBtn1");
         _levelBtn1.text = LanguageMgr.GetTranslation("consortion.levelBtn.text1");
         _levelBtn2 = ComponentFactory.Instance.creatComponentByStylename("consortion.levelBtn2");
         _levelBtn2.text = LanguageMgr.GetTranslation("consortion.levelBtn.text2");
         _levelBtn3 = ComponentFactory.Instance.creatComponentByStylename("consortion.levelBtn3");
         _levelBtn3.text = LanguageMgr.GetTranslation("consortion.levelBtn.text3");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_levelBtn1);
         _btnGroup.addSelectItem(_levelBtn2);
         _btnGroup.addSelectItem(_levelBtn3);
         _btnGroup.selectIndex = 0;
         var _loc1_:* = false;
         _levelBtn3.displacement = _loc1_;
         _loc1_ = _loc1_;
         _levelBtn2.displacement = _loc1_;
         _levelBtn1.displacement = _loc1_;
         addChild(_levelBtn1);
         addChild(_levelBtn2);
         addChild(_levelBtn3);
         _list = new BadgeShopList();
         _list.setList(BadgeInfoManager.instance.getBadgeInfoByLevel(1,3));
         PositionUtils.setPos(_list,"consortiaBadgeList.pos");
         addChild(_list);
         _btnGroup.addEventListener("change",onSelectChange);
      }
      
      private function onSelectChange(param1:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _list.setList(BadgeInfoManager.instance.getBadgeInfoByLevel(1,3));
               break;
            case 1:
               _list.setList(BadgeInfoManager.instance.getBadgeInfoByLevel(4,7));
               break;
            case 2:
               _list.setList(BadgeInfoManager.instance.getBadgeInfoByLevel(8,10));
         }
         SoundManager.instance.playButtonSound();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_levelBtn1);
         _levelBtn1 = null;
         ObjectUtils.disposeObject(_levelBtn2);
         _levelBtn2 = null;
         ObjectUtils.disposeObject(_levelBtn3);
         _levelBtn3 = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
