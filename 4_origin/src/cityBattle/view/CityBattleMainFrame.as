package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.events.MouseEvent;
   
   public class CityBattleMainFrame extends Frame
   {
       
      
      private var _castellanTerritorialBtn:SelectedButton;
      
      private var _territorialContentionBtn:SelectedButton;
      
      private var _territorialWelfareBtn:SelectedButton;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _view;
      
      private var _btnHelp:BaseButton;
      
      private var _redTxt:FilterFrameText;
      
      private var _blueTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _currentIndex:int;
      
      public var changeBtn:Boolean;
      
      public function CityBattleMainFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _hBox = ComponentFactory.Instance.creatComponentByStylename("cityBattle.view.hBox");
         addToContent(_hBox);
         _castellanTerritorialBtn = ComponentFactory.Instance.creatComponentByStylename("cityBattle.castellanTerritorial.btn");
         _territorialContentionBtn = ComponentFactory.Instance.creatComponentByStylename("cityBattle.territorialContention.btn");
         _territorialWelfareBtn = ComponentFactory.Instance.creatComponentByStylename("cityBattle.territorialWelfare.btn");
         _btnGroup = new SelectedButtonGroup();
         _hBox.addChild(_castellanTerritorialBtn);
         _hBox.addChild(_territorialContentionBtn);
         _hBox.addChild(_territorialWelfareBtn);
         _btnGroup.addSelectItem(_castellanTerritorialBtn);
         _btnGroup.addSelectItem(_territorialContentionBtn);
         _btnGroup.addSelectItem(_territorialWelfareBtn);
         var _loc1_:int = 0;
         _btnGroup.selectIndex = _loc1_;
         _currentIndex = _loc1_;
         changeView(1);
         _blueTxt = ComponentFactory.Instance.creatComponentByStylename("cityBattle.blueSide.txt");
         addToContent(_blueTxt);
         _redTxt = ComponentFactory.Instance.creatComponentByStylename("cityBattle.redSide.txt");
         addToContent(_redTxt);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("cityBattle.activityTime.txt");
         addToContent(_timeTxt);
         _timeTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.activity.time",ServerConfigManager.instance.cityOccupationStartDate,ServerConfigManager.instance.cityOccupationEndDate);
         if(CityBattleManager.instance.mySide == 1)
         {
            _blueTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.mySide.blue");
         }
         else
         {
            _redTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.mySide.red");
         }
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":629,
            "y":5
         },LanguageMgr.GetTranslation("ddt.cityBattle.help.title"),"asset.cityBattle.view.help",408,488);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         _castellanTerritorialBtn.removeEventListener("click",__changeHandler);
         _territorialContentionBtn.removeEventListener("click",__changeHandler);
         _territorialWelfareBtn.removeEventListener("click",__changeHandler);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
         _castellanTerritorialBtn.addEventListener("click",__changeHandler);
         _territorialContentionBtn.addEventListener("click",__changeHandler);
         _territorialWelfareBtn.addEventListener("click",__changeHandler);
      }
      
      protected function __changeHandler(event:MouseEvent) : void
      {
         if(_btnGroup.selectIndex == _currentIndex)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc2_:* = event.currentTarget;
         if(_castellanTerritorialBtn !== _loc2_)
         {
            if(_territorialContentionBtn !== _loc2_)
            {
               if(_territorialWelfareBtn === _loc2_)
               {
                  changeBtn = true;
                  if(CityBattleManager.instance.now > 0 && CityBattleManager.instance.now < 8)
                  {
                     SocketManager.Instance.out.cityBattleExchange(CityBattleManager.instance.now);
                  }
                  else
                  {
                     SocketManager.Instance.out.cityBattleExchange(7);
                  }
               }
            }
            else if(CityBattleManager.instance.contentionFirstData)
            {
               changeView(2);
            }
            else
            {
               SocketManager.Instance.out.cityBattleRank();
            }
         }
         else
         {
            changeView(1);
         }
         _currentIndex = _btnGroup.selectIndex;
      }
      
      public function changeView(type:int) : void
      {
         ObjectUtils.disposeObject(_view);
         _view = null;
         switch(int(type) - 1)
         {
            case 0:
               _view = new CastellanView();
               break;
            case 1:
               _view = new ContentionView();
               break;
            case 2:
               _view = new WelfareView();
         }
         if(_view)
         {
            _view.y = -10;
            addToContent(_view);
         }
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_castellanTerritorialBtn);
         _castellanTerritorialBtn = null;
         ObjectUtils.disposeObject(_territorialContentionBtn);
         _territorialContentionBtn = null;
         ObjectUtils.disposeObject(_territorialWelfareBtn);
         _territorialWelfareBtn = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         ObjectUtils.disposeObject(_blueTxt);
         _blueTxt = null;
         ObjectUtils.disposeObject(_redTxt);
         _redTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         CityBattleManager.instance.contentionFirstData = false;
         super.dispose();
      }
   }
}
