package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import horse.data.HorseEvent;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   
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
      
      public function HorseSkillFrameCell(data:Vector.<HorseSkillGetVo>)
      {
         super();
         _dataList = data;
         confirmCurShowSkillId();
         initView();
         initEvent();
         refreshView();
      }
      
      private function confirmCurShowSkillId() : void
      {
         var len:int = 0;
         var i:int = 0;
         var tmpGetList:Vector.<HorseSkillExpVo> = HorseManager.instance.curHasSkillList;
         var _loc6_:int = 0;
         var _loc5_:* = tmpGetList;
         for each(var tmp in tmpGetList)
         {
            len = _dataList.length;
            for(i = 0; i < len; )
            {
               if(tmp.skillId == _dataList[i].SkillID)
               {
                  _isGet = true;
                  _index = i;
                  _curShowSkill = tmp;
                  break;
               }
               i++;
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
      
      private function __mouseClick(evt:MouseEvent) : void
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
         var tmpPlace:int = HorseManager.instance.takeUpSkillPlace;
         if(tmpPlace == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillEquipMax"));
            return;
         }
         SocketManager.Instance.out.sendHorseTakeUpDownSkill(_curShowSkill.skillId,tmpPlace);
      }
      
      private function initEvent() : void
      {
         _upBtn.addEventListener("click",upClickHandler,false,0,true);
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
         HorseManager.instance.addEventListener("horseUpSkill",upSkillSucHandler);
         HorseManager.instance.addEventListener("showNewSkillView",upSkillSucHandler);
      }
      
      private function upSkillSucHandler(event:Event) : void
      {
         confirmCurShowSkillId();
         refreshView();
      }
      
      private function upClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         HorseManager.instance.dispatchEvent(new HorseEvent("upHorseSkill",{
            "index":_index,
            "curShowSkill":_curShowSkill,
            "dataList":_dataList
         }));
      }
      
      private function getClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var skillId:int = _curShowSkill.skillId;
         var level:int = HorseManager.instance.getLevelBySkillId(skillId);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillGetLevelPrompt",int(level / 10) + 1,level % 10));
      }
      
      private function removeEvent() : void
      {
         _upBtn.removeEventListener("click",upClickHandler);
         _getBtn.removeEventListener("click",getClickHandler);
         HorseManager.instance.removeEventListener("horseUpSkill",upSkillSucHandler);
         HorseManager.instance.removeEventListener("showNewSkillView",upSkillSucHandler);
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
