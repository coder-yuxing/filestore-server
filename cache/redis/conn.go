package redis

import (
	"github.com/garyburd/redigo/redis"
	"time"
)

var (
	redisPool *redis.Pool
	redisHost = "127.0.0.1:6379"
	redisPass = "123456"
)

func newRedisPool() *redis.Pool {
	return &redis.Pool{
		MaxIdle: 50,
		MaxActive: 30,
		IdleTimeout: 300 * time.Second,
		Dial: func() (redis.Conn, error) {
			// 1. 打开连接
			conn, err := redis.Dial("tcp", redisHost)
			if err != nil {
				return nil, err
			}
			// 2. 访问认证
			if _, err := conn.Do("AUTH", redisPass); err != nil {
				conn.Close()
				return nil, err
			}
			return conn, nil
		},
		TestOnBorrow: func(c redis.Conn, t time.Time) error {
			if time.Since(t) < time.Minute {
				return nil
			}
			_, err := c.Do("PING")
			return err
		},
	}
}

func init() {
	redisPool = newRedisPool()
}

func RedisPool() *redis.Pool {
	return redisPool
}

