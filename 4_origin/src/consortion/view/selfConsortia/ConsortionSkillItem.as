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
      
      public function ConsortionSkillItem(level:int, open:Boolean, isMetal:Boolean = false)
      {
         super();
         _level = level;
         _open = open;
         _isMetal = isMetal;
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
         var i:int = 0;
         if(_open)
         {
            for(i = 0; i < _cells.length; )
            {
               if(_cells[i])
               {
                  _cells[i].removeEventListener("click",__clickHandler);
               }
               if(_btns[i])
               {
                  _btns[i].removeEventListener("click",__clickHandler);
               }
               i++;
            }
         }
      }
      
      public function set data(value:Vector.<ConsortionSkillInfo>) : void
      {
         var i:int = 0;
         var cell:* = null;
         var btn:* = null;
         for(i = 0; i < value.length; )
         {
            cell = new ConsortionSkillCell();
            cell.tipData = value[i];
            cell.contentRect(54,54);
            addChild(cell);
            PositionUtils.setPos(cell,"consortion.killItem.cellPos" + i);
            btn = new ConsortionSkillItenBtn();
            addChild(btn);
            PositionUtils.setPos(btn,"consortion.killItem.btnPos" + i);
            if(value[i].type == 1)
            {
               btn.setValue(LanguageMgr.GetTranslation("ddt.consortion.skillItem.oneDay"),value[i].riches + " " + LanguageMgr.GetTranslation("consortia.Money"));
            }
            else if(_isMetal)
            {
               btn.setValue(LanguageMgr.GetTranslation("ddt.consortion.skillItem.oneDay"),value[i].metal + " " + LanguageMgr.GetTranslation("medalMoney"));
            }
            else
            {
               btn.setValue(LanguageMgr.GetTranslation("ddt.consortion.skillItem.oneDay"),value[i].riches + " " + LanguageMgr.GetTranslation("ddt.consortion.skillCell.btnPersonal.rich"));
            }
            cell.addEventListener("click",__clickHandler);
            btn.addEventListener("click",__clickHandler);
            _cells[i] = cell;
            _btns[i] = btn;
            i++;
         }
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(event.currentTarget is ConsortionSkillCell)
         {
            _currentInfo = (event.currentTarget as ConsortionSkillCell).info;
         }
         else
         {
            _currentInfo = _cells[_btns.indexOf(event.currentTarget as ConsortionSkillItenBtn)].info;
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
         var frame:ConsortionOpenSkillFrame = ComponentFactory.Instance.creatComponentByStylename("consortionOpenSkillFrame");
         frame.isMetal = _isMetal;
         frame.info = _currentInfo;
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      private function __confirmResponseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendConsortionSkill(false,_currentInfo.id,0);
         }
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__confirmResponseHandler);
         frame.dispose();
         frame = null;
      }
      
      override public function get height() : Number
      {
         return _bg1.height;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         for(i = 0; i < 2; )
         {
            _cells[i] = null;
            _btns[i] = null;
            i++;
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
