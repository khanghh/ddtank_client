package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionSkillInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortionSkillItem extends Sprite implements Disposeable
   {
       
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _bg3:ScaleBitmapImage;
      
      private var _cellBG1:DisplayObject;
      
      private var _cellBG2:DisplayObject;
      
      private var _sign:FilterFrameText;
      
      private var _level:int;
      
      private var _open:Boolean;
      
      private var _isMetal:Boolean;
      
      private var _cells:Vector.<ConsortionSkillCell>;
      
      private var _btns:Vector.<ConsortionSkillItenBtn>;
      
      private var _currentInfo:ConsortionSkillInfo;
      
      public function ConsortionSkillItem(param1:int, param2:Boolean, param3:Boolean = false)
      {
         super();
         _level = param1;
         _open = param2;
         _isMetal = param3;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("skillFrame.ItemBG1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("skillFrame.ItemBG2");
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("skillFrame.ItemBG3");
         _cellBG1 = ComponentFactory.Instance.creatCustomObject("skillFrame.ItemCellBG1");
         _cellBG2 = ComponentFactory.Instance.creatCustomObject("skillFrame.ItemCellBG2");
         _sign = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.gradeText");
         _sign.text = "LV" + _level;
         addChild(_bg1);
         addChild(_bg2);
         addChild(_bg3);
         addChild(_cellBG1);
         addChild(_cellBG2);
         addChild(_sign);
         if(!_open)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            filters = null;
         }
         _cells = new Vector.<ConsortionSkillCell>(2);
         _btns = new Vector.<ConsortionSkillItenBtn>(2);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         if(_open)
         {
            _loc1_ = 0;
            while(_loc1_ < _cells.length)
            {
               if(_cells[_loc1_])
               {
                  _cells[_loc1_].removeEventListener("click",__clickHandler);
               }
               if(_btns[_loc1_])
               {
                  _btns[_loc1_].removeEventListener("click",__clickHandler);
               }
               _loc1_++;
            }
         }
      }
      
      public function set data(param1:Vector.<ConsortionSkillInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new ConsortionSkillCell();
            _loc3_.tipData = param1[_loc4_];
            _loc3_.contentRect(54,54);
            addChild(_loc3_);
            PositionUtils.setPos(_loc3_,"consortion.killItem.cellPos" + _loc4_);
            _loc2_ = new ConsortionSkillItenBtn();
            addChild(_loc2_);
            PositionUtils.setPos(_loc2_,"consortion.killItem.btnPos" + _loc4_);
            if(param1[_loc4_].type == 1)
            {
               _loc2_.setValue(LanguageMgr.GetTranslation("ddt.consortion.skillItem.oneDay"),param1[_loc4_].riches + " " + LanguageMgr.GetTranslation("consortia.Money"));
            }
            else if(_isMetal)
            {
               _loc2_.setValue(LanguageMgr.GetTranslation("ddt.consortion.skillItem.oneDay"),param1[_loc4_].metal + " " + LanguageMgr.GetTranslation("medalMoney"));
            }
            else
            {
               _loc2_.setValue(LanguageMgr.GetTranslation("ddt.consortion.skillItem.oneDay"),param1[_loc4_].riches + " " + LanguageMgr.GetTranslation("ddt.consortion.skillCell.btnPersonal.rich"));
            }
            _loc3_.addEventListener("click",__clickHandler);
            _loc2_.addEventListener("click",__clickHandler);
            _cells[_loc4_] = _loc3_;
            _btns[_loc4_] = _loc2_;
            _loc4_++;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(param1.currentTarget is ConsortionSkillCell)
         {
            _currentInfo = (param1.currentTarget as ConsortionSkillCell).info;
         }
         else
         {
            _currentInfo = _cells[_btns.indexOf(param1.currentTarget as ConsortionSkillItenBtn)].info;
         }
         if(_currentInfo.type == 1 && PlayerManager.Instance.Self.DutyLevel > 2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.SkillFrame.info"));
            return;
         }
         if(!_open)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.skillItem.click.open"));
            return;
         }
         var _loc2_:ConsortionOpenSkillFrame = ComponentFactory.Instance.creatComponentByStylename("consortionOpenSkillFrame");
         _loc2_.isMetal = _isMetal;
         _loc2_.info = _currentInfo;
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function __confirmResponseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendConsortionSkill(false,_currentInfo.id,0);
         }
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirmResponseHandler);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      override public function get height() : Number
      {
         return _bg1.height;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _cells[_loc1_] = null;
            _btns[_loc1_] = null;
            _loc1_++;
         }
         _bg1 = null;
         _bg2 = null;
         _bg3 = null;
         _cellBG1 = null;
         _cellBG2 = null;
         _sign = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
