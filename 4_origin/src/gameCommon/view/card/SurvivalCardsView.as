package gameCommon.view.card
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   import road7th.comm.PackageIn;
   
   public class SurvivalCardsView extends LargeCardsView
   {
       
      
      private var _flopIcon:Image;
      
      private var _flopBg:Image;
      
      private var _flopCount:FilterFrameText;
      
      public function SurvivalCardsView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         deleteVipInfo();
         _title = ComponentFactory.Instance.creat("asset.takeoutCard.survival.title");
         PositionUtils.setPos(_title,"takeoutCard.LargeCardViewTitlePos");
         addChild(_title);
         _instructionTxt = ComponentFactory.Instance.creatBitmap("asset.takeoutCard.survival.InstructionBitmap");
         addChild(_instructionTxt);
         _flopIcon = ComponentFactory.Instance.creatComponentByStylename("gameOver.FlopIcon");
         addChild(_flopIcon);
         _flopBg = ComponentFactory.Instance.creatComponentByStylename("gameOver.FlopCountBg");
         addChild(_flopBg);
         _flopCount = ComponentFactory.Instance.creatComponentByStylename("gameOver.FlopCountTxt");
         _flopCount.text = GameControl.Instance.Current.selfGamePlayer.GetCardCount.toString();
         addChild(_flopCount);
      }
      
      override protected function __takeOut(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc7_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc8_:* = null;
         if(_cards.length > 0)
         {
            _loc5_ = param1.pkg;
            _loc7_ = _loc5_.readBoolean();
            if(!_systemToken && _loc7_)
            {
               _systemToken = true;
               __disabledAllCards();
            }
            _loc6_ = _loc5_.readByte();
            if(_loc6_ == 50)
            {
               return;
            }
            _loc2_ = _loc5_.readInt();
            _loc4_ = _loc5_.readInt();
            _loc3_ = _loc5_.readBoolean();
            _loc8_ = _gameInfo.findPlayer(_loc5_.extend1);
            if(_loc5_.clientId == _gameInfo.selfGamePlayer.playerInfo.ID)
            {
               _loc8_ = _gameInfo.selfGamePlayer;
            }
            if(_loc8_)
            {
               _cards[_loc6_].play(_loc8_,_loc2_,_loc4_,_loc3_);
               if(_loc8_.isSelf)
               {
                  _selectedCnt = Number(_selectedCnt) + 1;
                  if(_flopCount)
                  {
                     _flopCount.text = (_loc8_.GetCardCount - _selectedCnt).toString();
                  }
                  _selectCompleted = _selectedCnt >= _loc8_.GetCardCount;
                  if(_selectCompleted)
                  {
                     __disabledAllCards();
                     return;
                  }
               }
            }
            if(_loc7_)
            {
               showAllCard();
            }
         }
         else
         {
            _resultCards.push(param1);
         }
      }
      
      override protected function __countDownComplete(param1:Event) : void
      {
         _countDownView.removeEventListener("complete",__countDownComplete);
         __disabledAllCards();
         _timerForView.start();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_flopIcon);
         _flopIcon = null;
         ObjectUtils.disposeObject(_flopBg);
         _flopBg = null;
         ObjectUtils.disposeObject(_flopCount);
         _flopCount = null;
         super.dispose();
      }
   }
}
