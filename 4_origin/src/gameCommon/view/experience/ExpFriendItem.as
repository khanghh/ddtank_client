package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   import gameCommon.view.playerThumbnail.HeadFigure;
   
   public class ExpFriendItem extends Sprite implements Disposeable
   {
       
      
      private var _head:HeadFigure;
      
      private var _nameTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _exploitTxt:FilterFrameText;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function ExpFriendItem(player:Player)
      {
         super();
         init(player);
      }
      
      private function init(player:Player) : void
      {
         var tempIndex:int = 0;
         _head = new HeadFigure(28,28,player);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("experience.LeftViewNameTxt");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("experience.LeftViewScoreTxt");
         _exploitTxt = ComponentFactory.Instance.creatComponentByStylename("experience.LeftViewScoreTxt");
         PositionUtils.setPos(_exploitTxt,"experience.FriendItemTxtPos_3");
         PositionUtils.setPos(_head,"experience.FriendItemHeadPos");
         _nameTxt.text = player.playerInfo.NickName;
         if(_nameTxt.width > 85)
         {
            tempIndex = _nameTxt.getCharIndexAtPoint(85,5);
            _nameTxt.text = _nameTxt.text.substring(0,tempIndex) + "...";
         }
         _expTxt.text = "+" + player.expObj.gainGP;
         if(GameControl.Instance.Current.roomType == 120)
         {
            _exploitTxt.text = "+" + player.expObj.prestige.toString();
         }
         else if(player.expObj.gainOffer)
         {
            if(player.GainOffer < 0)
            {
               _exploitTxt.text = player.GainOffer.toString();
            }
            else
            {
               _exploitTxt.text = "+" + player.GainOffer.toString();
            }
         }
         else
         {
            _exploitTxt.text = "+0";
         }
         addChild(_head);
         addChild(_nameTxt);
         addChild(_expTxt);
         addChild(_exploitTxt);
         if(player.playerInfo.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            PositionUtils.setPos(_attestBtn,"experience.ItemAttestPos");
            addChild(_attestBtn);
         }
      }
      
      public function dispose() : void
      {
         if(_head)
         {
            _head.dispose();
            _head = null;
         }
         if(_nameTxt)
         {
            _nameTxt.dispose();
            _nameTxt = null;
         }
         if(_expTxt)
         {
            _expTxt.dispose();
            _expTxt = null;
         }
         if(_exploitTxt)
         {
            _exploitTxt.dispose();
            _exploitTxt = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
