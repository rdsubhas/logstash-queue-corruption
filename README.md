### Logstash full data loss with Persistent Queues

- Run `test.sh`
- Output:

```
subhasdandapani@MacBook-Subhas ~/P/r/logstash-queue-corruption> subl .
subhasdandapani@MacBook-Subhas ~/P/r/logstash-queue-corruption> docker logs -f c9de63be5901^C
subhasdandapani@MacBook-Subhas ~/P/r/logstash-queue-corruption> dock^C
subhasdandapani@MacBook-Subhas ~/P/r/logstash-queue-corruption> ./test.sh
Sending build context to Docker daemon  81.41kB
Step 1 : FROM docker.elastic.co/logstash/logstash:5.6.1
 ---> c3813901f5c0
Step 2 : COPY logstash.yml /usr/share/logstash/config/logstash.yml
 ---> Using cache
 ---> 35da1425b395
Step 3 : COPY pipeline.conf /usr/share/logstash/pipeline/logstash.conf
 ---> bdfc8c93b1b6
Removing intermediate container bab6b84bc0be
Successfully built bdfc8c93b1b6
Started container 3359bcbd85329e4e49bb55b9c381620a914a7a2024dced345a246c0e7dfb295b
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
Waiting for http input to become ready...
ok[1] Send normal int must be OK
ok[2] Send normal int must be OK
ok[3] Send normal int must be OK
ok[4] Send normal int must be OK
ok[5] Send normal int must be OK
ok####
#### SENDING BIGINT AND CORRUPTING THE QUEUE
####
ok####
#### LOGSTASH IS DEAD NOW, WILL WORK NO MORE
####
Sending Logstash's logs to /usr/share/logstash/logs which is now configured via log4j2.properties
[2017-09-23T13:09:52,479][INFO ][logstash.modules.scaffold] Initializing module {:module_name=>"netflow", :directory=>"/usr/share/logstash/modules/netflow/configuration"}
[2017-09-23T13:09:52,484][INFO ][logstash.modules.scaffold] Initializing module {:module_name=>"fb_apache", :directory=>"/usr/share/logstash/modules/fb_apache/configuration"}
[2017-09-23T13:09:52,503][INFO ][logstash.modules.scaffold] Initializing module {:module_name=>"arcsight", :directory=>"/usr/share/logstash/vendor/bundle/jruby/1.9/gems/x-pack-5.6.1-java/modules/arcsight/configuration"}
[2017-09-23T13:09:52,513][INFO ][logstash.setting.writabledirectory] Creating directory {:setting=>"path.queue", :path=>"/usr/share/logstash/data/queue"}
[2017-09-23T13:09:52,514][INFO ][logstash.setting.writabledirectory] Creating directory {:setting=>"path.dead_letter_queue", :path=>"/usr/share/logstash/data/dead_letter_queue"}
[2017-09-23T13:09:52,564][INFO ][logstash.agent           ] No persistent UUID file found. Generating new UUID {:uuid=>"7f2e2ad3-cce9-41d3-8dd7-384925df9733", :path=>"/usr/share/logstash/data/uuid"}
[2017-09-23T13:09:53,008][INFO ][logstash.pipeline        ] Starting pipeline {"id"=>"main", "pipeline.workers"=>2, "pipeline.batch.size"=>125, "pipeline.batch.delay"=>5, "pipeline.max_inflight"=>250}
[2017-09-23T13:09:53,058][INFO ][logstash.pipeline        ] Pipeline main started
[2017-09-23T13:09:53,167][INFO ][logstash.agent           ] Successfully started Logstash API endpoint {:port=>9600}

.... some normal messages ...

Exception in thread "[main]>worker0" Exception in thread "[main]>worker1" org.logstash.ackedqueue.QueueRuntimeException: deserialize invocation error
  at org.logstash.ackedqueue.Queue.deserialize(Queue.java:658)
  at org.logstash.ackedqueue.Page.readBatch(Page.java:60)
  at org.logstash.ackedqueue.Queue._readPageBatch(Queue.java:525)
  at org.logstash.ackedqueue.Queue.readBatch(Queue.java:516)
  at org.logstash.ackedqueue.ext.JrubyAckedQueueExtLibrary$RubyAckedQueue.ruby_read_batch(JrubyAckedQueueExtLibrary.java:162)
  at org.logstash.ackedqueue.ext.JrubyAckedQueueExtLibrary$RubyAckedQueue$INVOKER$i$2$0$ruby_read_batch.call(JrubyAckedQueueExtLibrary$RubyAckedQueue$INVOKER$i$2$0$ruby_read_batch.gen)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:202)
  at rubyjit.LogStash::Util::WrappedAckedQueue$$read_batch_652566213d0cb31c8b444e96975325b8b8be385d1975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:68)
  at rubyjit.LogStash::Util::WrappedAckedQueue$$read_batch_652566213d0cb31c8b444e96975325b8b8be385d1975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb)
  at org.jruby.internal.runtime.methods.JittedMethod.call(JittedMethod.java:221)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:202)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadBatch$$read_next_13bb2c5300feb721c7ed1f9c9921ea63de7ea4091975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:260)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadBatch$$read_next_13bb2c5300feb721c7ed1f9c9921ea63de7ea4091975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb)
  at org.jruby.internal.runtime.methods.JittedMethod.call(JittedMethod.java:141)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:134)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadClient$$read_batch_10a3ebe1d3f6875a3464e171e0d471789d3483171975012498.chained_0_ensure_1$RUBY$__ensure__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:172)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadClient$$read_batch_10a3ebe1d3f6875a3464e171e0d471789d3483171975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:171)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadClient$$read_batch_10a3ebe1d3f6875a3464e171e0d471789d3483171975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb)
  at org.jruby.internal.runtime.methods.JittedMethod.call(JittedMethod.java:141)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:134)
  at org.jruby.ast.CallNoArgNode.interpret(CallNoArgNode.java:60)
  at org.jruby.ast.LocalAsgnNode.interpret(LocalAsgnNode.java:123)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode.java:105)
  at org.jruby.ast.BlockNode.interpret(BlockNode.java:71)
  at org.jruby.ast.WhileNode.interpret(WhileNode.java:131)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode.java:105)
  at org.jruby.ast.BlockNode.interpret(BlockNode.java:71)
  at org.jruby.evaluator.ASTInterpreter.INTERPRET_METHOD(ASTInterpreter.java:74)
  at org.jruby.internal.runtime.methods.InterpretedMethod.call(InterpretedMethod.java:225)
  at org.jruby.internal.runtime.methods.DefaultMethod.call(DefaultMethod.java:219)
  at org.jruby.runtime.callsite.CachingCallSite.cacheAndCall(CachingCallSite.java:346)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:204)
  at org.jruby.ast.FCallTwoArgNode.interpret(FCallTwoArgNode.java:38)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode.java:105)
  at org.jruby.ast.BlockNode.interpret(BlockNode.java:71)
  at org.jruby.evaluator.ASTInterpreter.INTERPRET_BLOCK(ASTInterpreter.java:112)
  at org.jruby.runtime.Interpreted19Block.evalBlockBody(Interpreted19Block.java:206)
  at org.jruby.runtime.Interpreted19Block.yield(Interpreted19Block.java:194)
  at org.jruby.runtime.Interpreted19Block.call(Interpreted19Block.java:125)
  at org.jruby.runtime.Block.call(Block.java:101)
  at org.jruby.RubyProc.call(RubyProc.java:300)
  at org.jruby.RubyProc.call(RubyProc.java:230)
  at org.jruby.internal.runtime.RubyRunnable.run(RubyRunnable.java:103)
  at java.lang.Thread.run(Thread.java:748)
Caused by: java.lang.reflect.InvocationTargetException
  at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
  at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
  at java.lang.reflect.Method.invoke(Method.java:498)
  at org.logstash.ackedqueue.Queue.deserialize(Queue.java:656)
  ... 43 more
Caused by: java.lang.IllegalArgumentException: Missing Valuefier handling for full class name=[B, simple name=byte[]
  at org.logstash.Valuefier.convertNonCollection(Valuefier.java:48)
  at org.logstash.Valuefier.convert(Valuefier.java:87)
  at org.logstash.ConvertedMap.newFromMap(ConvertedMap.java:20)
  at org.logstash.Event.<init>(Event.java:62)
  at org.logstash.Event.fromSerializableMap(Event.java:204)
  at org.logstash.Event.deserialize(Event.java:427)
  ... 48 more
Caused by: java.lang.IllegalArgumentException: No enum constant org.logstash.bivalues.BiValues.[B
  at java.lang.Enum.valueOf(Enum.java:238)
  at org.logstash.bivalues.BiValues.valueOf(BiValues.java:18)
  at org.logstash.bivalues.BiValues.newBiValue(BiValues.java:88)
  at org.logstash.Valuefier.convertNonCollection(Valuefier.java:45)
  ... 53 more
org.logstash.ackedqueue.QueueRuntimeException: deserialize invocation error
  at org.logstash.ackedqueue.Queue.deserialize(Queue.java:658)
  at org.logstash.ackedqueue.Page.readBatch(Page.java:60)
  at org.logstash.ackedqueue.Queue._readPageBatch(Queue.java:525)
  at org.logstash.ackedqueue.Queue.readBatch(Queue.java:516)
  at org.logstash.ackedqueue.ext.JrubyAckedQueueExtLibrary$RubyAckedQueue.ruby_read_batch(JrubyAckedQueueExtLibrary.java:162)
  at org.logstash.ackedqueue.ext.JrubyAckedQueueExtLibrary$RubyAckedQueue$INVOKER$i$2$0$ruby_read_batch.call(JrubyAckedQueueExtLibrary$RubyAckedQueue$INVOKER$i$2$0$ruby_read_batch.gen)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:202)
  at rubyjit.LogStash::Util::WrappedAckedQueue$$read_batch_652566213d0cb31c8b444e96975325b8b8be385d1975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:68)
  at rubyjit.LogStash::Util::WrappedAckedQueue$$read_batch_652566213d0cb31c8b444e96975325b8b8be385d1975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb)
  at org.jruby.internal.runtime.methods.JittedMethod.call(JittedMethod.java:221)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:202)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadBatch$$read_next_13bb2c5300feb721c7ed1f9c9921ea63de7ea4091975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:260)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadBatch$$read_next_13bb2c5300feb721c7ed1f9c9921ea63de7ea4091975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb)
  at org.jruby.internal.runtime.methods.JittedMethod.call(JittedMethod.java:141)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:134)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadClient$$read_batch_10a3ebe1d3f6875a3464e171e0d471789d3483171975012498.chained_0_ensure_1$RUBY$__ensure__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:172)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadClient$$read_batch_10a3ebe1d3f6875a3464e171e0d471789d3483171975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb:171)
  at rubyjit.LogStash::Util::WrappedAckedQueue::ReadClient$$read_batch_10a3ebe1d3f6875a3464e171e0d471789d3483171975012498.__file__(/usr/share/logstash/logstash-core/lib/logstash/util/wrapped_acked_queue.rb)
  at org.jruby.internal.runtime.methods.JittedMethod.call(JittedMethod.java:141)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:134)
  at org.jruby.ast.CallNoArgNode.interpret(CallNoArgNode.java:60)
  at org.jruby.ast.LocalAsgnNode.interpret(LocalAsgnNode.java:123)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode.java:105)
  at org.jruby.ast.BlockNode.interpret(BlockNode.java:71)
  at org.jruby.ast.WhileNode.interpret(WhileNode.java:131)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode.java:105)
  at org.jruby.ast.BlockNode.interpret(BlockNode.java:71)
  at org.jruby.evaluator.ASTInterpreter.INTERPRET_METHOD(ASTInterpreter.java:74)
  at org.jruby.internal.runtime.methods.InterpretedMethod.call(InterpretedMethod.java:225)
  at org.jruby.internal.runtime.methods.DefaultMethod.call(DefaultMethod.java:219)
  at org.jruby.runtime.callsite.CachingCallSite.call(CachingCallSite.java:202)
  at org.jruby.ast.FCallTwoArgNode.interpret(FCallTwoArgNode.java:38)
  at org.jruby.ast.NewlineNode.interpret(NewlineNode.java:105)
  at org.jruby.ast.BlockNode.interpret(BlockNode.java:71)
  at org.jruby.evaluator.ASTInterpreter.INTERPRET_BLOCK(ASTInterpreter.java:112)
  at org.jruby.runtime.Interpreted19Block.evalBlockBody(Interpreted19Block.java:206)
  at org.jruby.runtime.Interpreted19Block.yield(Interpreted19Block.java:194)
  at org.jruby.runtime.Interpreted19Block.call(Interpreted19Block.java:125)
  at org.jruby.runtime.Block.call(Block.java:101)
  at org.jruby.RubyProc.call(RubyProc.java:300)
  at org.jruby.RubyProc.call(RubyProc.java:230)
  at org.jruby.internal.runtime.RubyRunnable.run(RubyRunnable.java:103)
  at java.lang.Thread.run(Thread.java:748)
Caused by: java.lang.reflect.InvocationTargetException
  at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
  at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
  at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
  at java.lang.reflect.Method.invoke(Method.java:498)
  at org.logstash.ackedqueue.Queue.deserialize(Queue.java:656)
  ... 42 more
Caused by: java.lang.IllegalArgumentException: Missing Valuefier handling for full class name=[B, simple name=byte[]
  at org.logstash.Valuefier.convertNonCollection(Valuefier.java:48)
  at org.logstash.Valuefier.convert(Valuefier.java:87)
  at org.logstash.ConvertedMap.newFromMap(ConvertedMap.java:20)
  at org.logstash.Event.<init>(Event.java:62)
  at org.logstash.Event.fromSerializableMap(Event.java:204)
  at org.logstash.Event.deserialize(Event.java:427)
  ... 47 more
Caused by: java.lang.IllegalArgumentException: No enum constant org.logstash.bivalues.BiValues.[B
  at java.lang.Enum.valueOf(Enum.java:238)
  at org.logstash.bivalues.BiValues.valueOf(BiValues.java:18)
  at org.logstash.bivalues.BiValues.newBiValue(BiValues.java:88)
  at org.logstash.Valuefier.convertNonCollection(Valuefier.java:45)
  ... 52 more

... from here its data loss all the way ...

```
