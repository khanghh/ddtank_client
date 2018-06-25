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
      
      override protected function __takeOut(e:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var isSysTake:Boolean = false;
         var place:Number = NaN;
         var templateID:int = 0;
         var count:int = 0;
         var isVip:Boolean = false;
         var info:* = null;
         if(_cards.length > 0)
         {
            pkg = e.pkg;
            isSysTake = pkg.readBoolean();
            if(!_systemToken && isSysTake)
            {
               _systemToken = true;
               __disabledAllCards();
            }
            place = pkg.readByte();
            if(place == 50)
            {
               return;
            }
            templateID = pkg.readInt();
            count = pkg.readInt();
            isVip = pkg.readBoolean();
            info = _gameInfo.findPlayer(pkg.extend1);
            if(pkg.clientId == _gameInfo.selfGamePlayer.playerInfo.ID)
            {
               info = _gameInfo.selfGamePlayer;
            }
            if(info)
            {
               _cards[place].play(info,templateID,count,isVip);
               if(info.isSelf)
               {
                  _selectedCnt = Number(_selectedCnt) + 1;
                  if(_flopCount)
                  {
                     _flopCount.text = (info.GetCardCount - _selectedCnt).toString();
                  }
                  _selectCompleted = _selectedCnt >= info.GetCardCount;
                  if(_selectCompleted)
                  {
                     __disabledAllCards();
                     return;
                  }
               }
            }
            if(isSysTake)
            {
               showAllCard();
            }
         }
         else
         {
            _resultCards.push(e);
         }
      }
      
      override protected function __countDownComplete(event:Event) : void
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
