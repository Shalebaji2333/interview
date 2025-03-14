/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : mianshi

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 19/02/2025 14:23:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for experience
-- ----------------------------
DROP TABLE IF EXISTS `experience`;
CREATE TABLE `experience`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `tags` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签列表（json 数组）',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '参考答案',
  `userId` bigint(0) NOT NULL COMMENT '创建用户 id',
  `thumbNum` int(0) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `editTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '编辑时间',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `isDelete` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_title`(`title`) USING BTREE,
  INDEX `idx_userId`(`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '面试经验' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of experience
-- ----------------------------
INSERT INTO `experience` VALUES (6, '6666', '6667', '[6666, 7777]', '', 5, 8, '2025-02-17 15:47:39', '2025-02-17 15:47:39', '2025-02-18 13:25:14', 0);

-- ----------------------------
-- Table structure for experience_thumb
-- ----------------------------
DROP TABLE IF EXISTS `experience_thumb`;
CREATE TABLE `experience_thumb`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `experienceId` bigint(0) NOT NULL COMMENT '面试经验 id',
  `userId` bigint(0) NOT NULL COMMENT '用户 id',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `isDelete` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_userId`(`userId`) USING BTREE,
  INDEX `idx_experienceId`(`experienceId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '面试经验点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of experience_thumb
-- ----------------------------
INSERT INTO `experience_thumb` VALUES (46, 6, 5, '2025-02-18 13:24:56', '2025-02-18 13:25:06', 1);
INSERT INTO `experience_thumb` VALUES (47, 6, 5, '2025-02-18 13:25:14', '2025-02-18 13:25:14', 0);

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `tags` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签列表（json 数组）',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '推荐答案',
  `userId` bigint(0) NOT NULL COMMENT '创建用户 id',
  `editTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '编辑时间',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `isDelete` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_title`(`title`) USING BTREE,
  INDEX `idx_userId`(`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1891362785971884035 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '题目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, 'JavaScript Promise 使用', '请解释 JavaScript 中 Promise 的使用方法。', '[\"JavaScript\", \"高级\"]', 'Promise 是一个对象，用于表示异步操作的最终完成或失败。它有三种状态：Pending（进行中）、Fulfilled（已成功）和 Rejected（已失败）。使用 Promise 可以避免回调地狱，使异步代码更加清晰易读。例如，可以使用 new Promise() 创建一个 Promise 对象，通过 then() 方法处理成功的结果，通过 catch() 方法处理失败的错误。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (2, 'CSS 预处理器使用', '如何使用 CSS 预处理器？', '[\"CSS\", \"高级技巧\"]', 'CSS 预处理器如 Sass、Less 等，它们扩展了 CSS 的功能，允许使用变量、嵌套规则、混合（mixins）等特性。以 Sass 为例，首先需要安装 Sass，然后可以创建一个 .scss 文件，在其中定义变量，如 $primary-color: #333;，使用嵌套规则来组织 CSS 代码，使样式表更加模块化和易于维护。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (3, 'HTML5 Canvas 绘图', '请说明如何使用 HTML5 的 Canvas 进行绘图。', '[\"HTML5\", \"新特性\"]', 'Canvas 是 HTML5 提供的一个绘图 API，可以在网页上绘制图形、图像等。首先需要在 HTML 中添加一个 canvas 元素，如 <canvas id=\"myCanvas\" width=\"200\" height=\"100\"></canvas>。然后通过 JavaScript 获取 canvas 元素的上下文，如 var ctx = document.getElementById(\"myCanvas\").getContext(\"2d\");，接着使用上下文对象提供的绘图方法，如 ctx.fillRect(x, y, width, height) 绘制矩形，ctx.arc(x, y, radius, startAngle, endAngle) 绘制圆形等。', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (4, 'React 高阶组件', '什么是 React 中的高阶组件？', '[\"React\", \"进阶\"]', '高阶组件（HOC）是 React 中的一种高级技术，用于复用组件逻辑。它是一个函数，接受一个组件作为参数，并返回一个新的组件。通过高阶组件，可以在不修改原有组件代码的情况下，为组件添加额外的逻辑或属性。例如，可以创建一个 withLogging 高阶组件，用于在组件渲染前后打印日志，这样就可以将日志记录的逻辑与组件的业务逻辑分离，提高代码的复用性和可维护性。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (5, '算法：动态规划', '请实现一个动态规划算法。', '[\"算法\", \"优化\"]', '动态规划是一种解决多阶段决策问题的算法思想，它将问题分解为多个子问题，并通过存储子问题的解来避免重复计算。以背包问题为例，假设有一个背包和若干个物品，每个物品有重量和价值，背包的容量有限，目标是选择物品使得背包中的总价值最大。可以使用一个二维数组 dp 来存储子问题的解，其中 dp[i][j] 表示前 i 个物品在背包容量为 j 时的最大价值。通过遍历物品和背包容量，根据是否选择当前物品来更新 dp 数组的值，最终 dp[n][w]（n 为物品数量，w 为背包容量）即为背包问题的最优解。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (6, '数据库存储过程', '什么是数据库存储过程？如何使用？', '[\"数据库\", \"高级应用\"]', '存储过程是数据库中的一组预编译的 SQL 语句，它封装了复杂的业务逻辑，可以提高数据库操作的效率和安全性。在 MySQL 中，可以使用 DELIMITER 关键字来改变语句的结束符，然后使用 CREATE PROCEDURE 语句创建存储过程，如 CREATE PROCEDURE GetUsers() BEGIN SELECT * FROM users; END;。调用存储过程时，使用 CALL 关键字，如 CALL GetUsers();。通过存储过程，可以减少网络传输的次数，提高数据库的性能，同时也可以避免 SQL 注入等安全问题。', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (7, '操作系统内存管理', '请解释操作系统中的内存管理机制。', '[\"操作系统\", \"进阶\"]', '操作系统通过内存管理机制来分配和回收内存资源，确保多个进程能够高效地共享内存。常见的内存管理技术包括分页和分段。分页管理将内存划分为固定大小的页面，进程的地址空间也被划分为同样大小的页框，通过页表来实现逻辑地址到物理地址的映射。分段管理则是将内存划分为大小不等的段，每个段对应进程的一个逻辑模块，通过段表来管理段的分配和回收。现代操作系统通常结合分页和分段管理，以提高内存的利用率和访问效率。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (8, '网络协议：WebSocket', '请解释 WebSocket 协议及其应用。', '[\"网络\", \"进阶协议\"]', 'WebSocket 是一种在单个 TCP 连接上进行全双工通信的协议，它提供了一个在浏览器和服务器之间进行实时双向通信的通道。与传统的 HTTP 协议相比，WebSocket 在连接建立后，数据可以随时发送，无需像 HTTP 那样每次发送请求和响应都需要建立和关闭连接。WebSocket 协议在实时通信应用中非常有用，如在线游戏、股票交易平台、实时聊天系统等。客户端可以通过 WebSocket API 建立连接，如 var socket = new WebSocket(\'ws://example.com/socketserver\');，然后通过 socket 的 onopen、onmessage、onerror 和 onclose 事件来处理连接的打开、消息接收、错误处理和连接关闭等事件。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (9, '设计模式：策略模式', '请解释策略模式的实现及应用场景。', '[\"设计模式\", \"进阶\"]', '策略模式定义了一系列的算法，把它们一个个封装起来，并使它们可以互换。策略模式让算法的变化独立于使用算法的客户。例如，在一个图形编辑软件中，可以定义一个绘图策略接口，如 DrawStrategy，它有一个 draw() 方法。然后实现不同的绘图策略类，如 RectangleDrawStrategy、CircleDrawStrategy 等，它们都实现了 DrawStrategy 接口。在绘图上下文中，根据用户的输入选择不同的绘图策略，并调用其 draw() 方法来绘制图形。这样，当需要添加新的绘图策略时，只需新增一个策略类并实现接口，无需修改上下文代码，符合开闭原则。', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (10, 'Python 装饰器使用', '请解释 Python 中装饰器的使用方法。', '[\"编程语言\", \"Python\", \"高级特性\"]', '装饰器是 Python 中一种非常有用的特性，它可以修改一个函数、方法或类的行为。装饰器本质上是一个函数，它接收一个函数作为参数，并返回一个新的函数。使用装饰器时，只需在函数定义前加上 @decorator_name 即可。例如，可以创建一个 logging 装饰器，用于在函数执行前后打印日志。当使用 @logging 装饰一个函数时，调用该函数时就会自动打印日志，并且不会影响函数本身的执行。装饰器可以用于权限验证、性能测试、事务处理等多种场景。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (11, 'Git 钩子使用', '如何使用 Git 钩子？', '[\"版本控制\", \"Git\", \"高级应用\"]', 'Git 钩子是 Git 提供的一种自动化机制，可以在特定的事件发生时自动执行脚本。例如，在提交代码前可以使用 pre-commit 钩子来检查代码风格是否符合规范，提交后可以使用 post-commit 钩子来发送通知。要使用 Git 钩子，需要在项目的 .git/hooks 目录下找到对应的钩子文件，如 pre-commit.sample，去掉文件名的 .sample 后缀，然后编辑该文件，添加需要执行的脚本代码。当对应的 Git 事件发生时，就会自动执行该钩子脚本。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (12, '加密算法：RSA', '请解释 RSA 加密算法的原理及应用。', '[\"安全\", \"加密\", \"进阶\"]', 'RSA 是一种非对称加密算法，它使用一对密钥，即公钥和私钥。公钥用于加密数据，私钥用于解密数据。RSA 算法的原理基于大整数分解的困难性，选择两个大素数 p 和 q，计算它们的乘积 n=p*q，然后选择一个小于 n 且与 (p-1)*(q-1) 互质的整数 e，计算 e 的模逆元 d。公钥为 (n, e)，私钥为 (n, d)。加密时，将明文 m 转换为整数，计算密文 c=m^e mod n；解密时，计算明文 m=c^d mod n。RSA 算法广泛应用于数字签名、加密通信等领域，如 SSL/TLS 协议中就使用了 RSA 算法来加密传输密钥。', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (13, '云计算：弹性计算', '请解释云计算中的弹性计算概念。', '[\"云计算\", \"进阶\"]', '弹性计算是云计算的一个重要特性，它允许用户根据需求动态地分配和释放计算资源。例如，在业务高峰期，可以自动增加服务器的数量来提高处理能力；在业务低谷期，可以减少服务器的数量来降低成本。弹性计算通常通过云服务提供商提供的 API 或管理控制台来实现，用户可以设置资源的伸缩策略，如根据 CPU 使用率、内存使用率等指标自动调整资源。这样，用户无需提前购买大量硬件资源，可以根据实际业务需求灵活地使用云计算资源，提高资源的利用率和经济效益。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (14, '微服务容错机制', '微服务架构中如何实现容错机制？', '[\"微服务\", \"进阶\"]', '在微服务架构中，容错机制是非常重要的，因为微服务之间通过网络进行通信，可能会出现服务不可用、网络延迟等问题。常见的容错机制包括断路器模式、重试机制、超时机制等。断路器模式可以防止故障扩散，当某个服务调用失败达到一定次数时，断路器会自动跳闸，阻止后续的调用，同时可以进行降级处理，如返回默认值或缓存数据。重试机制可以在服务调用失败时自动重试，但需要设置合理的重试次数和间隔时间，避免对服务造成更大的压力。超时机制可以设置服务调用的超时时间，当调用时间超过设定值时，自动终止调用并进行相应的处理。通过这些容错机制，可以提高微服务架构的可靠性和稳定性。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (15, '容器技术：Dockerfile 编写', '如何编写 Dockerfile 来创建 Docker 镜像？', '[\"容器技术\", \"Docker\", \"进阶\"]', 'Dockerfile 是一个文本文件，用于定义如何构建 Docker 镜像。它包含了一系列的指令，如 FROM、RUN、COPY、EXPOSE、CMD 等。FROM 指令用于指定基础镜像，RUN 指令用于执行命令，COPY 指令用于将文件从宿主机复制到镜像中，EXPOSE 指令用于声明容器运行时监听的端口，CMD 指令用于指定容器启动时执行的命令。例如，要创建一个包含 Node.js 应用的 Docker 镜像，可以在 Dockerfile 中写入以下内容：FROM node:14，WORKDIR /app，COPY package.json /app，RUN npm install，COPY . /app，EXPOSE 3000，CMD [\"node\", \"app.js\"]。然后使用 docker build 命令构建镜像，使用 docker run 命令运行容器。', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (16, 'DevOps 持续集成工具', '列举并解释常用的 DevOps 持续集成工具。', '[\"DevOps\", \"高级实践\"]', '常用的 DevOps 持续集成工具有 Jenkins、Travis CI、GitLab CI/CD 等。Jenkins 是一个开源的自动化服务器，可以用于构建、测试和部署软件项目。它支持多种插件，可以与各种版本控制系统、构建工具和测试框架集成。Travis CI 是一个基于云的持续集成服务，主要用于 GitHub 项目。它通过分析项目的配置文件来自动执行构建和测试任务。GitLab CI/CD 是 GitLab 提供的持续集成和持续交付功能，它与 GitLab 代码仓库紧密集成，可以方便地实现从代码提交到部署的自动化流程。这些工具可以提高软件开发的效率和质量，实现快速迭代和持续交付。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (17, '数据分析：数据挖掘算法', '请介绍几种常用的数据挖掘算法。', '[\"数据分析\", \"进阶\"]', '数据挖掘是从大量数据中提取有用信息的过程，常用的算法包括分类算法、聚类算法、关联规则算法等。分类算法如决策树算法（ID3、C4.5 等），通过构建决策树模型来对数据进行分类；支持向量机（SVM）算法，通过寻找最优分割超平面来区分不同类别的数据。聚类算法如 K-Means 算法，将数据分为 K 个簇，使簇内数据相似度高，簇间数据相似度低；层次聚类算法，通过构建层次结构来逐步合并或分割数据簇。关联规则算法如 Apriori 算法，用于发现数据中频繁项集之间的关联关系，如购物篮分析中发现购买面包的顾客很可能也会购买牛奶。这些算法在数据分析、机器学习等领域有广泛的应用。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (18, '人工智能：深度学习框架', '请介绍几种常见的深度学习框架。', '[\"人工智能\", \"进阶\"]', '深度学习框架是用于构建和训练深度神经网络的工具，常见的框架包括 TensorFlow、PyTorch、Keras 等。TensorFlow 是由 Google 开发的开源机器学习框架，它提供了丰富的 API 和工具，支持多种深度学习模型的构建和训练，如卷积神经网络（CNN）、循环神经网络（RNN）等。PyTorch 是由 Facebook 开发的开源机器学习库，它以动态计算图和易用性著称，适合进行快速原型开发和研究。Keras 是一个高层神经网络 API，它可以运行在 TensorFlow、CNTK、Theano 等后端之上，提供了简洁易用的接口来构建和训练神经网络。这些框架大大降低了深度学习的开发门槛，推动了人工智能技术的发展。', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (19, '区块链：智能合约', '请解释区块链中的智能合约概念。', '[\"区块链\", \"进阶\"]', '智能合约是一种自动执行、控制或记录法律事件和行动的计算机程序。在区块链中，智能合约被存储在区块链上，一旦满足预设的条件，就会自动执行合约中的条款。例如，在一个供应链金融场景中，可以创建一个智能合约，当货物到达指定地点并且验收合格时，自动触发支付流程。智能合约具有去中心化、不可篡改、自动执行等特点，可以提高交易的效率和安全性，降低信任成本。以 Ethereum 为例，它提供了一个智能合约平台，开发者可以使用 Solidity 等编程语言编写智能合约，并将其部署到 Ethereum 区块链上。', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (20, '项目管理：敏捷开发方法', '请介绍敏捷开发方法及其在项目管理中的应用。', '[\"项目管理\", \"高级应用\"]', '敏捷开发是一种以人为核心、迭代、循序渐进的开发方法，它强调在整个开发过程中的适应性和灵活性。常见的敏捷开发方法有 Scrum、Kanban 等。Scrum 方法将项目分为多个短周期的迭代，称为 Sprint，每个 Sprint 通常持续 2-4 周。在每个 Sprint 开始时，团队会从产品待办事项列表中选择一部分工作进行开发，并在 Sprint 结束时交付一个可用的软件增量。Kanban 方法则通过可视化工作流程和限制在制品数量来提高团队的效率和响应能力。敏捷开发方法在项目管理中的应用可以提高项目的适应性，快速响应变化，提高团队的协作和沟通效率，从而提高项目的成功率。', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question` VALUES (21, '浏览器渲染原理', '请详细解释浏览器的渲染过程和关键渲染路径（Critical Rendering Path）。', '[\"前端\", \"浏览器\", \"性能优化\"]', '浏览器渲染过程主要包含以下步骤：\n\r\n1. HTML解析：将HTML解析成DOM树\n\r\n2. CSS解析：将CSS解析成CSSOM树\n\r\n3. 合并：将DOM和CSSOM合并成渲染树（Render Tree）\n\r\n4. 布局：计算每个节点在屏幕中的确切位置和大小\n\r\n5. 绘制：将渲染树的各个节点绘制到屏幕上\n\n\r\n优化关键渲染路径的方法：\n\r\n- 减少关键资源的数量\n\r\n- 减少关键资源的大小\n\r\n- 优化加载顺序\n\r\n- 使用异步加载非关键资源\n\r\n- 避免渲染阻塞JavaScript和CSS', 1, '2025-02-17 10:40:06', '2025-02-17 10:40:06', '2025-02-17 10:40:06', 0);
INSERT INTO `question` VALUES (1891336183049273345, '1', '1111', '[\"1111\"]', '1111', 5, '2025-02-17 11:57:40', '2025-02-17 11:57:40', '2025-02-17 11:57:40', 0);
INSERT INTO `question` VALUES (1891336419394109441, '222', '222', '[\"222\"]', '222', 5, '2025-02-17 11:58:36', '2025-02-17 11:58:36', '2025-02-17 11:58:36', 0);
INSERT INTO `question` VALUES (1891336766795726850, '333', '333', '[\"3333\"]', '3333', 5, '2025-02-17 11:59:59', '2025-02-17 11:59:59', '2025-02-17 11:59:59', 0);
INSERT INTO `question` VALUES (1891338189373620225, '444', '444', '[\"444\"]', '444', 5, '2025-02-17 12:05:38', '2025-02-17 12:05:38', '2025-02-17 12:05:38', 0);
INSERT INTO `question` VALUES (1891338610968281090, '555', '55', '[\"5\"]', '55', 5, '2025-02-17 12:07:18', '2025-02-17 12:07:18', '2025-02-17 12:07:18', 0);
INSERT INTO `question` VALUES (1891362785971884034, '7777', '7777', '[\"7777\"]', '7777', 5, '2025-02-17 13:43:22', '2025-02-17 13:43:22', '2025-02-17 13:43:22', 0);

-- ----------------------------
-- Table structure for question_bank
-- ----------------------------
DROP TABLE IF EXISTS `question_bank`;
CREATE TABLE `question_bank`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '描述',
  `picture` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `userId` bigint(0) NOT NULL COMMENT '创建用户 id',
  `editTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '编辑时间',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `isDelete` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_title`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '题库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question_bank
-- ----------------------------
INSERT INTO `question_bank` VALUES (1, 'JavaScript 高级应用', '包含 JavaScript 的高级应用题目', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (2, 'CSS 高级技巧', '包含 CSS 相关的高级技巧问题', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (3, 'HTML5 新特性', 'HTML5 标记语言的新特性知识', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (4, '前端框架进阶', 'React, Vue, Angular 等框架的进阶题目', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (5, '算法优化', '数据结构和算法优化题目', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (6, '数据库高级应用', 'SQL 语句和数据库设计的高级应用', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (7, '操作系统进阶', '操作系统高级概念', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (8, '网络协议进阶', 'HTTP, TCP/IP 等网络协议进阶题目', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (9, '设计模式进阶', '高级设计模式及其应用', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (10, '编程语言高级特性', '多种编程语言的高级特性知识', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (11, '版本控制高级应用', 'Git 和 SVN 的高级使用', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (12, '安全与加密进阶', '网络安全和加密技术的进阶', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (13, '云计算进阶', '云服务和架构的高级应用', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (14, '微服务架构进阶', '微服务的高级设计与实现', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (15, '容器技术进阶', 'Docker 和 Kubernetes 的高级知识', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (16, 'DevOps 高级实践', '持续集成与持续交付的高级实践', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (17, '数据分析进阶', '高级数据分析和可视化', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (18, '人工智能进阶', '机器学习与深度学习的高级应用', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 3, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (19, '区块链技术进阶', '区块链高级原理和应用', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `question_bank` VALUES (20, '项目管理高级应用', '软件开发项目高级管理和执行', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);

-- ----------------------------
-- Table structure for question_bank_question
-- ----------------------------
DROP TABLE IF EXISTS `question_bank_question`;
CREATE TABLE `question_bank_question`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `questionBankId` bigint(0) NOT NULL COMMENT '题库 id',
  `questionId` bigint(0) NOT NULL COMMENT '题目 id',
  `userId` bigint(0) NOT NULL COMMENT '创建用户 id',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `questionBankId`(`questionBankId`, `questionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '题库题目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question_bank_question
-- ----------------------------
INSERT INTO `question_bank_question` VALUES (1, 1, 1, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (2, 1, 2, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (3, 2, 3, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (4, 2, 4, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (5, 3, 5, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (6, 3, 6, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (7, 4, 7, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (8, 4, 8, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (9, 5, 9, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (10, 5, 10, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (11, 6, 11, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (12, 6, 12, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (13, 7, 13, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (14, 7, 14, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (15, 8, 15, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (16, 8, 16, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (17, 9, 17, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (18, 9, 18, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (19, 10, 19, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (20, 10, 20, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (21, 11, 21, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (22, 11, 22, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (23, 12, 23, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (24, 12, 24, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (25, 13, 25, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (26, 13, 26, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (27, 14, 27, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (28, 14, 28, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (29, 15, 29, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (30, 15, 30, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (31, 16, 31, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (32, 16, 32, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (33, 17, 33, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (34, 17, 34, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (35, 18, 35, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (36, 18, 36, 3, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (37, 19, 37, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (38, 19, 38, 1, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (39, 20, 39, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');
INSERT INTO `question_bank_question` VALUES (40, 20, 40, 2, '2025-01-15 23:06:02', '2025-01-15 23:06:02');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userAccount` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
  `userPassword` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `unionId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信开放平台id',
  `mpOpenId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公众号openId',
  `userName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `userAvatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `userProfile` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户简介',
  `userRole` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user/admin/ban',
  `editTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '编辑时间',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `isDelete` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_unionId`(`unionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1891313048287625218 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'user1', 'b0dd3697a192885d7c055db46155b26a', 'unionId1', 'mpOpenId1', 'user1', 'https://www.code-nav.cn/logo.png', '喜欢编程的小白', 'user', '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `user` VALUES (2, 'user2', 'b0dd3697a192885d7c055db46155b26a', 'unionId2', 'mpOpenId2', 'user2', 'https://www.code-nav.cn/logo.png', '全栈开发工程师', 'user', '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `user` VALUES (3, 'user3', 'b0dd3697a192885d7c055db46155b26a', 'unionId3', 'mpOpenId3', 'user3', 'https://www.code-nav.cn/logo.png', '前端爱好者', 'user', '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `user` VALUES (4, 'user4', 'b0dd3697a192885d7c055db46155b26a', 'unionId4', 'mpOpenId4', 'user4', 'https://www.code-nav.cn/logo.png', '后端开发工程师', 'user', '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-01-15 23:06:01', 0);
INSERT INTO `user` VALUES (5, 'admin', '45360bded66e2a29b68d2b523568b994', NULL, NULL, 'SsSzZzLl', 'https://img1.baidu.com/it/u=3287343560,3643604522&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '系统管理员', 'admin', '2025-01-15 23:06:01', '2025-01-15 23:06:01', '2025-02-17 15:46:28', 0);
INSERT INTO `user` VALUES (1891313048287625217, 'zhangsan', '45360bded66e2a29b68d2b523568b994', NULL, NULL, NULL, NULL, NULL, 'user', '2025-02-17 10:25:44', '2025-02-17 10:25:44', '2025-02-17 10:25:44', 0);

SET FOREIGN_KEY_CHECKS = 1;
