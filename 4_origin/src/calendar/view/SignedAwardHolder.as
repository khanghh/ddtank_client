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
      
      public function SignedAwardHolder(param1:CalendarModel)
      {
         _awardCells = new Vector.<SignAwardCell>();
         super();
         _model = param1;
         configUI();
      }
      
      public function setAwardsByCount(param1:int) : void
      {
         var _loc4_:* = null;
         clean();
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("ddtcalendar.Award.cell.TopLeft");
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = _model.awards;
         for each(var _loc5_ in _model.awards)
         {
            if(_loc5_.AwardDays == param1)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("ddtcalendar.SignAwardCell");
               _awardCells.push(_loc4_);
               if(_loc5_.TemplateID == 1)
               {
                  _loc4_.info = ItemManager.Instance.getTemplateById(ServerConfigManager.instance.dailyRewardIDForMonth[TimeManager.Instance.Now().getMonth()]);
                  _loc4_.setCount(_loc5_.Count);
               }
               else
               {
                  _loc4_.info = ItemManager.Instance.getTemplateById(_loc5_.TemplateID);
                  _loc4_.setCount(_loc5_.Count);
               }
               _loc4_.x = _loc3_.x + _loc2_ * 132;
               _loc4_.y = _loc3_.y;
               addChild(_loc4_);
               _loc2_++;
            }
         }
         if(param1 == 28)
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
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _awardCells.length)
         {
            _loc1_ = _awardCells[_loc2_] as SignAwardCell;
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc2_++;
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
