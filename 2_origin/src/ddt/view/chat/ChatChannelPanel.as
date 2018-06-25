package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ChatChannelPanel extends ChatBasePanel
   {
       
      
      private var _bg:Bitmap;
      
      private var _channelBtns:Vector.<BaseButton>;
      
      private var _vbox:VBox;
      
      private var _currentChannel:Object;
      
      private const chanelMap:Array = [15,0,1,2,3,4,5];
      
      public function ChatChannelPanel()
      {
         _channelBtns = new Vector.<BaseButton>();
         _currentChannel = {};
         super();
      }
      
      private function __itemClickHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new ChatEvent("inputChannelChanged",_currentChannel[(e.target as BaseButton).backStyle]));
      }
      
      override protected function init() : void
      {
         var i:* = 0;
         super.init();
         _bg = ComponentFactory.Instance.creatBitmap("asset.chat.ChannelPannelBg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("chat.channelPanel.vbox");
         if(ShopManager.Instance.getMoneyShopItemByTemplateID(11100))
         {
            _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_CrossBuggleBtn"));
         }
         if(ShopManager.Instance.getMoneyShopItemByTemplateID(11102))
         {
            _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_BigBuggleBtn"));
         }
         if(ShopManager.Instance.getMoneyShopItemByTemplateID(11101))
         {
            _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_SmallBuggleBtn"));
         }
         _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_PrivateBtn"));
         _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_ConsortiaBtn"));
         _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_TeamBtn"));
         _channelBtns.push(ComponentFactory.Instance.creat("chat.ChannelState_CurrentBtn"));
         addChild(_bg);
         addChild(_vbox);
         for(i = uint(0); i < _channelBtns.length; )
         {
            _channelBtns[i].addEventListener("click",__itemClickHandler);
            _currentChannel[_channelBtns[i].backStyle] = chanelMap[7 - _channelBtns.length + i];
            _vbox.addChild(_channelBtns[i]);
            i++;
         }
         _bg.height = 18 * _channelBtns.length + 10;
      }
      
      public function get btnLen() : int
      {
         return _channelBtns.length;
      }
   }
}
