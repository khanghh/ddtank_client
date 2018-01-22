package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   import trainer.view.NewHandContainer;
   
   public class HorseSkillFrameCell extends Sprite implements Disposeable
   {
       
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _fullTxt:FilterFrameText;
      
      private var _skillCell:HorseSkillCell;
      
      private var _dataList:Vector.<HorseSkillGetVo>;
      
      private var _isGet:Boolean = false;
      
      private var _curShowSkill:HorseSkillExpVo;
      
      private var _index:int = -1;
      
      public function HorseSkillFrameCell(param1:Vector.<HorseSkillGetVo>)
      {
         super();
         _dataList = param1;
         confirmCurShowSkillId();
         initView();
         initEvent();
         refreshView();
      }
      
      private function confirmCurShowSkillId() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Vector.<HorseSkillExpVo> = HorseManager.instance.curHasSkillList;
         var _loc6_:int = 0;
         var _loc5_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            _loc3_ = _dataList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc2_.skillId == _dataList[_loc4_].SkillID)
               {
                  _isGet = true;
                  _index = _loc4_;
                  _curShowSkill = _loc2_;
                  break;
               }
               _loc4_++;
            }
         }
         if(!_curShowSkill)
         {
            _isGet = false;
            _index = -1;
            _curShowSkill = new HorseSkillExpVo();
            _curShowSkill.skillId = _dataList[0].SkillID;
         }
      }
      
      private function initView() : void
      {
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.cell.getBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.cell.upBtn");
         _fullTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.cell.fullTxt");
         _fullTxt.text = LanguageMgr.GetTranslation("horse.skillFrame.fullTxt");
         addChild(_getBtn);
         addChild(_upBtn);
         addChild(_fullTxt);
      }
      
      private function refreshView() : void
      {
         if(_skillCell)
         {
            _skillCell.removeEventListener("click",__mouseClick);
            _skillCell.dispose();
         }
         _skillCell = new HorseSkillCell(_curShowSkill.skillId);
         _skillCell.x = 5;
         _skillCell.addEventListener("click",__mouseClick,false,0,true);
         addChild(_skillCell);
         if(_isGet)
         {
            _getBtn.visible = false;
            if(_index == _dataList.length - 1)
            {
               _upBtn.visible = false;
               _fullTxt.visible = true;
            }
            else
            {
               _upBtn.visible = true;
               _fullTxt.visible = false;
            }
            _skillCell.filters = null;
            _skillCell.buttonMode = true;
         }
         else
         {
            _getBtn.visible = true;
            _upBtn.visible = false;
            _fullTxt.visible = false;
            _skillCell.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function __mouseClick(param1:MouseEvent) : void
      {
         if(!_isGet)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(HorseManager.instance.isSkillHasEquip(_curShowSkill.skillId))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillCannotEquipSame"));
            return;
         }
         var _loc2_:int = HorseManager.instance.takeUpSkillPlace;
         if(_loc2_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
            return;
         }
         SocketManager.Instance.out.sendHorseTakeUpDownSkill(_curShowSkill.skillId,_loc2_);
         if(!PlayerManager.Instance.Self.isNewOnceFinish(114))
         {
            SocketManager.Instance.out.syncWeakStep(114);
            NewHandContainer.Instance.clearArrowByID(128);
         }
      }
      
      private function initEvent() : void
      {
         _upBtn.addEventListener("click",upClickHandler,false,0,true);
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
         HorseManager.instance.addEventListener("horseUpSkill",upSkillSucHandler);
      }
      
      private function upSkillSucHandler(param1:Event) : void
      {
         confirmCurShowSkillId();
         refreshView();
      }
      
      private function upClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:HorseSkillUpFrame = ComponentFactory.Instance.creatComponentByStylename("HorseSkillUpFrame");
         _loc2_.show(_index,_curShowSkill,_dataList);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function getClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:int = _curShowSkill.skillId;
         var _loc2_:int = HorseManager.instance.getLevelBySkillId(_loc3_);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillGetLevelPrompt",int(_loc2_ / 10) + 1,_loc2_ % 10));
      }
      
      private function removeEvent() : void
      {
         _upBtn.removeEventListener("click",upClickHandler);
         _getBtn.removeEventListener("click",getClickHandler);
         HorseManager.instance.removeEventListener("horseUpSkill",upSkillSucHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _getBtn = null;
         _upBtn = null;
         _fullTxt = null;
         _skillCell = null;
         _dataList = null;
         _curShowSkill = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
