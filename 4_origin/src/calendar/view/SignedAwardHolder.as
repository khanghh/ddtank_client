package calendar.view
{
   import calendar.CalendarModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DaylyGiveInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class SignedAwardHolder extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _model:CalendarModel;
      
      private var _awardCells:Vector.<SignAwardCell>;
      
      private var _beeReward:DisplayObject;
      
      private var _bigBack:MutipleImage;
      
      private var _nameField:FilterFrameText;
      
      public function SignedAwardHolder(model:CalendarModel)
      {
         _awardCells = new Vector.<SignAwardCell>();
         super();
         _model = model;
         configUI();
      }
      
      public function setAwardsByCount(signCount:int) : void
      {
         var cell:* = null;
         clean();
         var topleft:Point = ComponentFactory.Instance.creatCustomObject("ddtcalendar.Award.cell.TopLeft");
         var count:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _model.awards;
         for each(var award in _model.awards)
         {
            if(award.AwardDays == signCount)
            {
               cell = ComponentFactory.Instance.creatCustomObject("ddtcalendar.SignAwardCell");
               _awardCells.push(cell);
               if(award.TemplateID == 1)
               {
                  cell.info = ItemManager.Instance.getTemplateById(ServerConfigManager.instance.dailyRewardIDForMonth[TimeManager.Instance.Now().getMonth()]);
                  cell.setCount(award.Count);
               }
               else
               {
                  cell.info = ItemManager.Instance.getTemplateById(award.TemplateID);
                  cell.setCount(award.Count);
               }
               cell.x = topleft.x + count * 132;
               cell.y = topleft.y;
               addChild(cell);
               count++;
            }
         }
         if(signCount == 28)
         {
            _bigBack = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.SignedAward.SignAwardCellBg2");
            addChild(_bigBack);
            PositionUtils.setPos(_bigBack,"ddtcalendar.SignedAward.SignAwardCellBgPos");
            _nameField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.AwardNameField");
            addChild(_nameField);
            _nameField.text = LanguageMgr.GetTranslation("signedAwardHolder.beeName");
            PositionUtils.setPos(_nameField,"ddtcalendar.AwardNameFieldPos");
            _beeReward = ComponentFactory.Instance.creat("ddtcalendar.bee");
            addChild(_beeReward);
            PositionUtils.setPos(_beeReward,"ddtcalendar.beePos");
            _bigBack.tipData = LanguageMgr.GetTranslation("signedAwardHolder.beeNameTipData");
         }
      }
      
      public function clean() : void
      {
         var cell:* = null;
         var i:int = 0;
         for(i = 0; i < _awardCells.length; )
         {
            cell = _awardCells[i] as SignAwardCell;
            ObjectUtils.disposeObject(cell);
            cell = null;
            i++;
         }
         _awardCells.splice(0,_awardCells.length);
         if(_beeReward)
         {
            ObjectUtils.disposeObject(_beeReward);
            _beeReward = null;
         }
         if(_bigBack)
         {
            ObjectUtils.disposeObject(_bigBack);
            _bigBack = null;
         }
         if(_nameField)
         {
            ObjectUtils.disposeObject(_nameField);
            _nameField = null;
         }
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.AwardHolderBack");
         addChild(_back);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         clean();
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
